class VideosController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:transcode]

  def new
    @video = Video.new
  end

  def transcode
    input = params[:input]
    outputs = params[:outputs]
    config = params[:config]
    Path.create_paths(outputs)
    video = Ffmpeg.new(input, outputs)
    video.probe
    Resque.enqueue(Transcoder, video.command, video.duration)
    render nothing: true
  end

  def create
    video = Video.create!(video_params)
    video.generate_paths
    Resque.enqueue(Transcoder, video)
    redirect_to action: :index
  end

  def index
    @videos = Video.page(params[:page]).order(:id)
  end

  def show
    @video = Video.find params[:id]
  end

  private

  def video_params
    params.require(:video).permit(:title, :video_file, :state, :audio_bitrate, :audio_sample_rate, :video_bitrate, :single_thread)
  end

end
