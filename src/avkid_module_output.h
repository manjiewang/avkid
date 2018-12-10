/**
 * @file   avkid_output.h
 * @author chef
 *
 */

#pragma once

#include "avkid_fwd.hpp"
#include "avkid_module_base.h"

namespace avkid {

class Output : public ModuleBase {
  public:
    Output(bool async_mode=false, enum AudioVideoFlag avf=AVF_BOTH);
    ~Output();
    static std::shared_ptr<Output> create(bool async_mode=false, enum AudioVideoFlag avf=AVF_BOTH);

    // TODO timeout
    bool open(const std::string &url, AVFormatContext *in_fmt_ctx, int width=-1, int height=-1);

    void do_data(AVPacket *pkt, bool is_audio);

  private:
    bool do_packet_(AVPacket *pkt, bool is_audio);

  private:
    AVFormatContext *out_fmt_ctx_ = nullptr;
    int audio_stream_index_ = -1;
    int video_stream_index_ = -1;

  private:
    Output(const Output &) = delete;
    Output &operator=(const Output &) = delete;

};

}
