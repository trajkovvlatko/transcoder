class Transcoder

  @queue = "transcode_queue"

  def self.perform(command, duration)
    progress = nil
    IO.popen(command) do |out|
      last_progress = 0
      out.each("r") do |line|
        if line =~ /time=(\d+).(\d+).(\d+)/
          current_time = ($1.to_i * 3600 + $2.to_i * 60 + $3.to_i)
          progress = 0
          progress = (current_time * 100 / duration).to_i if not duration.nil? and duration != 0 and current_time != 0
          progress = 100 if progress > 100
          puts "#{progress}%" if last_progress < progress
          last_progress = progress
        end
      end
    end
  end

end
