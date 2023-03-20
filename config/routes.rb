# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username),
                                                Digest::SHA256.hexdigest(ENV.fetch('HTTP_USERNAME', nil))) &
      ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password),
                                                  Digest::SHA256.hexdigest(ENV.fetch('HTTP_PASSWORD', nil)))
  end
  mount Sidekiq::Web => '/sidekiq'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :data_services, only: %i[create]
    end
  end

  resources :data_services, only: %i[index show]
  root 'home#index'
end
