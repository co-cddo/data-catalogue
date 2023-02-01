# frozen_string_literal: true

Rails.application.routes.draw do
  resources :data_services, only: %i[index show]

  root 'data_services#index'
end
