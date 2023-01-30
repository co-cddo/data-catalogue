# frozen_string_literal: true

Rails.application.routes.draw do
  resources :data_services, only: :index

  root 'data_services#index'
end
