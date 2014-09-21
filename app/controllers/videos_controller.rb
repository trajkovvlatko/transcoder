class VideosController < ApplicationController

  def new
    @video = Video.new
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
