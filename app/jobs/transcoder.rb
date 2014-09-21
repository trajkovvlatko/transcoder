class Transcoder

  @queue = "transcode_queue"

  def self.perform(video)
    puts "-------------------------------------"
    puts "transcoding #{video['input']} started..."
    cmd = "ffmpeg -i #{video['input']} -threads 1 -movflags faststart -acodec aac -strict experimental -b:a 192k -ar 44100 -vcodec h264 -vf \"scale=1280:720,pad=1280:720:0:0\" #{video['hi_output']} -threads 1 -movflags faststart -acodec aac -strict experimental -b:a 192k -ar 44100 -vcodec h264 -vf \"scale=640:360,pad=640:360:0:0\" #{video['low_output']} -threads 1 -movflags faststart -acodec aac -strict experimental -b:a 192k -ar 44100 -vcodec h264 -b:v 2500k -vf \"scale=1280:720,pad=1280:720:0:0\" #{video['ts_output']} -threads 1 -movflags faststart -b:a 192k -ar 44100 -vf \"scale=1280:720,pad=1280:720:0:0,select='not(mod(n,295))'\" -vsync 0 -vframes 5 #{video['thumbs_output']}"
    puts cmd
    system(cmd)
    puts "transcoding #{video['input']} finished."
    puts "-------------------------------------"
    Video.publish(video['id'])
  end

end
