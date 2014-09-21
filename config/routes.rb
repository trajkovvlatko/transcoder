Rails.application.routes.draw do

  require 'resque/server'

  TranscoderApp::Application.routes.draw do
    mount Resque::Server.new, at: "/resque"
  end

  resources :videos

  root "videos#index"

end
