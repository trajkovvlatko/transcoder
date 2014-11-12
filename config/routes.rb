Rails.application.routes.draw do

  require 'resque/server'

  TranscoderApp::Application.routes.draw do
    mount Resque::Server.new, at: "/resque"
  end

  resources :videos do
    collection do
      post "transcode" => "videos#transcode"
    end
  end

  root "videos#index"

end
