class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :video_file
      t.string :input
      t.string :hi_output
      t.string :low_output
      t.string :ts_output
      t.string :thumbs_output
      t.string :audio_bitrate
      t.string :audio_sample_rate
      t.string :video_bitrate
      t.boolean :single_thread, default: true
      t.integer :duration, limit: 8
      t.integer :size, limit: 8
      t.string :state, default: "queued"

      t.timestamps
    end
  end
end
