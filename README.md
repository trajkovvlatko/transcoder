Ruby on Rails transcoder
==========

Ruby on Rails application, video uploader and transcoder. 

It uses ffmpeg and Resque background jobs for the transcoding process.

Using:

install redis

$ bundle install

$ rake db:migrate (uses sqlite)

$ foreman start

visit <a href="http://localhost:3000">http://localhost:3000</a> for the web application

or    <a href="http://localhost:3000/resque">http://localhost:3000/resque</a> for Resque panel and background jobs management

