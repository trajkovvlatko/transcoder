web:    bundle exec rails s
worker1: bundle exec rake environment resque:work QUEUE=transcode_queue
worker2: bundle exec rake environment resque:work QUEUE=transcode_queue
worker3: bundle exec rake environment resque:work QUEUE=transcode_queue
