# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140920162120) do

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "video_file"
    t.string   "input"
    t.string   "hi_output"
    t.string   "low_output"
    t.string   "ts_output"
    t.string   "thumbs_output"
    t.string   "audio_bitrate"
    t.string   "audio_sample_rate"
    t.string   "video_bitrate"
    t.boolean  "single_thread",               default: true
    t.integer  "duration",          limit: 8
    t.integer  "size",              limit: 8
    t.string   "state",                       default: "queued"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
