/**
 * @file   avkid_module_encode.h
 * @author chef
 *
 */

#pragma once

#include "avkid_fwd.hpp"
#include "avkid_module_base.h"

namespace avkid {

class Encode : public ModuleBase, public PacketProducer {
  public:
    Encode(bool async_mode=false);
    ~Encode();
    static std::shared_ptr<Encode> create(bool async_mode=false);

    bool open(AVFormatContext *in_fmt_ctx, int width=-1, int height=-1);

    bool do_data(AVFrame *frame, bool is_audio);

  private:
    bool do_frame_(AVFrame *frame, bool is_audio);
    void do_audio_frame(AVFrame *frame);
    void do_video_frame(AVFrame *frame);

  private:
    AVCodecContext *audio_enc_ctx_ = nullptr;
    AVCodecContext *video_enc_ctx_ = nullptr;

  private:
    Encode(const Encode &) = delete;
    Encode &operator=(const Encode &) = delete;

};

}