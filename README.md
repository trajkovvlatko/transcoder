Ruby on Rails video transcoder
==========

Ruby on Rails application, video uploader and transcoder. 

It uses ffmpeg and Resque background jobs for the transcoding process.

Using:

Install redis

Build ffmpeg from source <a href="https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu">https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu</a>

$ bundle install

$ rake db:migrate (uses sqlite)

$ foreman start

send POST request to http://localhost:3000/videos/transcode

{"input":"/home/vlatko/Videos/Testing/1.mp4", "outputs":[{"url":"/home/vlatko/test/video/hi/hi.mp4", "width":"1280", "height":"720", "audio_codec":"aac", "video_codec":"h264", "single_thread":false}, {"url":"/home/vlatko/test/video/low/low.mp4", "width":"640", "height":"360", "audio_codec":"aac", "video_codec":"h264", "single_thread":false}, {"url":"/home/vlatko/test/video/ts/ts.ts", "width":"1280", "height":"720", "audio_codec":"aac", "audio_bitrate":"192k", "video_codec":"h264", "single_thread":false}, {"url":"/home/vlatko/test/video/thumbs/0%d.jpg", "width":"1280", "height":"720", "quantity":5, "single_thread":false}], "config": { "user_digest": "user_digest_bla", "video_id": "123", "landroval_key": "7b6f66c475f7bee0e73349259eae0608", "progress_url" : "http://localhost:3000/videos/progress", "success_url" : "http://localhost:3000/videos/success", "fail_url" : "http://localhost:3000/videos/fail" } }

or    <a href="http://localhost:3000/resque">http://localhost:3000/resque</a> for Resque panel and background jobs management

