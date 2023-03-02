# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username),
                                                Digest::SHA256.hexdigest(ENV.fetch('HTTP_USERNAME', nil))) &
      ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password),
                                                  Digest::SHA256.hexdigest(ENV.fetch('HTTP_PASSWORD', nil)))
  end

  mount Sidekiq::Web => '/sidekiq'

  resources :data_services, only: %i[index show]

  root 'home#index'
end
