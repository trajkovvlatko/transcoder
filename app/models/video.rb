class Video < ActiveRecord::Base

  mount_uploader :video_file, VideoUploader

  before_create :set_title

  paginates_per 10

  def generate_paths
    input_path
    hi_output_path
    low_output_path
    ts_path
    thumbs_path
    save!
  end

  def without_extension
    self.video_file.file.filename.split(".")[0...-1].join(".")
  end

  def extension
    self.video_file.file.filename.split(".").last
  end

  def set_title
    self.title = self.without_extension if self.new_record? && self.title.empty?
  end

  def input_path
    self.input = Rails.root.to_s + "/public" + self.video_file.to_s
  end

  def hi_output_path
    output = self.without_extension + "_transcoded.mp4"
    self.hi_output = Rails.root.to_s + "/public/uploads/video/video_file/#{self.id}/#{output}"
  end

  def low_output_path
    output = self.without_extension + "_transcoded_low.mp4"
    self.low_output = Rails.root.to_s + "/public/uploads/video/video_file/#{self.id}/#{output}"
  end

  def ts_path
    output = self.without_extension + ".ts"
    self.ts_output = Rails.root.to_s + "/public/uploads/video/video_file/#{self.id}/#{output}"
  end

  def thumbs_path
    output = self.without_extension + "%d.jpg"
    self.thumbs_output = Rails.root.to_s + "/public/uploads/video/video_file/#{self.id}/#{output}"
  end

  def self.set_state(id, state)
    video = Video.find(id)
    video.update_attributes({ state: state })
  end

end
