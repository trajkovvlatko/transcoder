transcoder
==========

Ruby on Rails application, video uploader and transcoder. 
It uses ffmpeg and Resque background jobs for the transcoding process.

Using:

$ bundle install

edit database.yml with proper db credentials

$ rake db:create
$ rake db:migrate

$ foreman start

visit http://localhost:3000 for the web application
or    http://localhost:3000/resque for Resque panel

