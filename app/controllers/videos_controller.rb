class VideosController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:transcode]

  def transcode
    input = params[:input]
    outputs = params[:outputs]
    config = params[:config]
    Path.create_paths(outputs)
    video = Ffmpeg.new(input, outputs)
    video.probe
    Resque.enqueue(Transcoder, video.id, video.command, video.duration)
    render nothing: true
  end

end
