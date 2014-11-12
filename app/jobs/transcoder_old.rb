class TranscoderOld

  @queue = "transcode_queue"

  def self.perform(video)
    Video.set_state(video['id'], "running")
    threads = video['single_thread'] ? "-threads 1" : ""

    puts "-------------------------------------"
    puts "transcoding #{video['input']} started..."
    cmd = "ffmpeg -i #{video['input']} " +
          " #{threads} -movflags faststart -acodec aac -strict experimental -b:a #{video['audio_bitrate']} -ar #{video['audio_sample_rate']} -vcodec h264 -b:v #{video['video_bitrate']} -vf \"scale=1280:720,pad=1280:720:0:0\" #{video['hi_output']} " +
          " #{threads} -movflags faststart -acodec aac -strict experimental -b:a #{video['audio_bitrate']} -ar #{video['audio_sample_rate']} -vcodec h264 -b:v #{video['video_bitrate']} -vf \"scale=640:360,pad=640:360:0:0\" #{video['low_output']} " +
          " #{threads} -movflags faststart -acodec aac -strict experimental -b:a #{video['audio_bitrate']} -ar #{video['audio_sample_rate']} -vcodec h264 -b:v #{video['video_bitrate']} -vf \"scale=1280:720,pad=1280:720:0:0\" #{video['ts_output']} " +
          " #{threads} -movflags faststart -b:a 192k -ar 44100 -vf \"scale=1280:720,pad=1280:720:0:0,select='not(mod(n,50))'\" -vsync 0 -vframes 5 #{video['thumbs_output']}"
    puts cmd
    system(cmd)
    puts "transcoding #{video['input']} finished."
    puts "-------------------------------------"

    Video.set_state(video['id'], "complete")
  end

end
