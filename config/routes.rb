# frozen_string_literal: true

Rails.application.routes.draw do

  mount GovukPublishingComponents::Engine, at: "/component-guide" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'data_services#index'
  get '/data_services', to: "data_services#index"
end
