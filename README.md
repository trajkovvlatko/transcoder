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

visit <a href="http://localhost:3000">http://localhost:3000</a> for the web application

or    <a href="http://localhost:3000/resque">http://localhost:3000/resque</a> for Resque panel and background jobs management

