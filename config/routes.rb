# frozen_string_literal: true

Rails.application.routes.draw do
  root 'data_services#index'
  resources :data_services, only: :index
end
