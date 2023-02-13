# frozen_string_literal: true
require 'sidekiq/web'
  
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :data_services, only: %i[index show]

  root 'data_services#index'
end
