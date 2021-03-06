CXXFLAGS = -g -O2 -std=c++11 -pipe -fPIC -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS  # -Wall
CXXFLAGS += -I./avkid/include

LINKFLAGS = -lavformat -lavcodec -lavutil -lavfilter -lswscale -lfdk-aac

all: libavkid rtmp_bc rtmpdump rtmp_decode_encode mix  audio_mix  multi_out audio_touch audio_mix2


AVKID_HEADER = $(wildcard avkid/include/*.h)
AVKID_HEADER += $(wildcard avkid/include/*.hpp)
AVKID_HEADER += $(wildcard avkid/include/chef_base/*.hpp)

AVKID_SRC = $(wildcard avkid/src/*.cc)

AVKID_OBJ = $(addprefix output/, $(patsubst %.cc,%.o,$(AVKID_SRC)))

output/avkid/src/%.o: avkid/src/%.cc $(AVKID_HEADER)
	@mkdir -p $(dir $@)
	g++ $(CXXFLAGS) -c $< -o $@

libavkid: $(AVKID_OBJ)
	@mkdir -p $(dir $@)
	ar -cr output/libavkid.a $(AVKID_OBJ)

rtmp_bc: avkid/example/exe_rtmp_bc.cc libavkid
	g++ $(CXXFLAGS) -o output/rtmp_bc avkid/example/exe_rtmp_bc.cc output/libavkid.a $(LINKFLAGS)

rtmpdump: avkid/example/exe_rtmpdump.cc libavkid
	g++ $(CXXFLAGS) -o output/rtmpdump avkid/example/exe_rtmpdump.cc output/libavkid.a $(LINKFLAGS)

rtmp_decode_encode: avkid/example/exe_rtmp_decode_encode.cc libavkid
	g++ $(CXXFLAGS) -o output/rtmp_decode_encode avkid/example/exe_rtmp_decode_encode.cc output/libavkid.a $(LINKFLAGS)

mix: avkid/example/exe_mix.cc libavkid
	g++ $(CXXFLAGS) -o output/mix avkid/example/exe_mix.cc output/libavkid.a $(LINKFLAGS)

audio_mix: avkid/example/exe_audio_mix.cc libavkid
	g++ $(CXXFLAGS) -o output/audio_mix avkid/example/exe_audio_mix.cc output/libavkid.a $(LINKFLAGS)

audio_mix2: avkid/example/exe_audio_mix2.cc libavkid
	g++ $(CXXFLAGS) -o output/audio_mix2 avkid/example/exe_audio_mix2.cc output/libavkid.a $(LINKFLAGS)

multi_out: avkid/example/exe_multi_out.cc libavkid
	g++ $(CXXFLAGS) -o output/multi_out avkid/example/exe_multi_out.cc output/libavkid.a $(LINKFLAGS)

audio_touch: avkid/example/exe_audio_touch.cc libavkid
	g++ $(CXXFLAGS) -o output/audio_touch avkid/example/exe_audio_touch.cc output/libavkid.a -I./third_party/soundtouch/include/soundtouch -L./third_party/soundtouch/lib -lSoundTouch $(LINKFLAGS)


clean:
	rm -rf output

