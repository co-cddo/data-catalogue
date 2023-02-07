# frozen_string_literal: true

module AuthHelper
  def http_auth_headers
    username = ENV.fetch('HTTP_USERNAME')
    password = ENV.fetch('HTTP_PASSWORD')
    {
      Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    }
  end
end
