class Transcoder

  def initialize(input, outputs)
    @input = input
    @outputs = outputs
    @metadata = {}
  end

  def command
    @command = []
    @command.push executable
    @command.push input
    @outputs.each do |output|
      @output = output
      if @output[:url].include?("thumb")
        @command.push "#{overwrite} #{single_thread} #{thumbs_settings} #{output_path}"
      else
        @command.push "#{overwrite} #{single_thread} #{flags} #{audio_codec} #{strict} #{audio_bitrate} #{audio_sample_rate} #{video_codec} #{video_bitrate} #{scale} #{output_path}"
      end
    end
    @command.push "2>&1"
    puts @command
    @command.join " "
  end

  def probe
    @metadata = JSON.parse(`ffprobe -v quiet -print_format json -show_format -show_streams #{@input}`)
  end

  def metadata
    @metadata
  end

  def video_frame_rate
    frame_rate = 25
    streams.each do |stream|
      frame_rate = eval(stream["avg_frame_rate"]) if stream["codec_type"] == "video"
    end
    frame_rate.to_i
  end

  def streams
    @metadata["streams"]
  end

  def format
    @metadata["format"]
  end

  def duration
    eval(@metadata["format"]["duration"])
  end

  def run
    progress = nil
    IO.popen(command) do |out|
      last_progress = 0
      out.each("r") do |line|
        if line =~ /time=(\d+).(\d+).(\d+)/
          current_time = ($1.to_i * 3600 + $2.to_i * 60 + $3.to_i)
          progress = 0
          progress = (current_time * 100 / duration).to_i if not duration.nil? and duration != 0 and current_time != 0
          progress = 100 if progress > 100
          Rails.logger.info "#{progress}%" if last_progress < progress
          last_progress = progress
        end
      end
    end
  end

  def executable
    "ffmpeg"
  end

  def input
    "-i #{@input}"
  end

  def overwrite
    "-y"
  end

  def single_thread
    @output[:single_thread] ? "-threads 1" : ""
  end

  def flags
   "-movflags faststart"
  end

  def audio_codec
    @output[:audio_codec] ? "-acodec #{@output[:audio_codec]}" : "-acodec aac"
  end

  def strict
    "-strict experimental"
  end

  def audio_bitrate
    @output[:audio_bitrate] ? "-b:a #{@output[:audio_bitrate]}" : "-b:a 192k"
  end

  def audio_sample_rate
    @output[:audio_sample_rate] ? "-ar #{@output[:audio_sample_rate]}" : "-ar 44100"
  end

  def video_codec
    @output[:video_codec] ? "-vcodec #{@output[:video_codec]}" : "-vcodec h264"
  end

  def video_bitrate
    @output[:video_bitrate] ? "-b:v #{@output[:video_bitrate]}" : "-b:v 3000k"
  end

  def scale
    @output[:width] && @output[:height] ? "-vf \"scale=#{@output[:width]}:#{@output[:height]},pad=#{@output[:width]}:#{@output[:height]}:0:0\"" : ""
  end

  def output_path
    @output[:url]
  end

  def thumbs_settings
    coeff = (duration.to_i * video_frame_rate / @output[:quantity]).floor
    "-vsync 0 -vframes 5 -vf \"scale=1280:720,pad=1280:720:0:0,select='not(mod(n,#{coeff}))'\""
  end

end
