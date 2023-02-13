# frozen_string_literal: true
require 'sidekiq/web'
  
Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["HTTP_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["HTTP_PASSWORD"]))
  end
  
  mount Sidekiq::Web => '/sidekiq'

  resources :data_services, only: %i[index show]

  root 'data_services#index'
end
