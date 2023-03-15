# frozen_string_literal: true

class ApplicationController < ActionController::Base
  http_basic_authenticate_with  name: ENV.fetch('HTTP_USERNAME'),
                                password: ENV.fetch('HTTP_PASSWORD')
  include Pagy::Backend
end
