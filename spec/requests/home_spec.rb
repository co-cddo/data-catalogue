# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homepage' do
  include AuthHelper

  context 'when unauthorised' do
    describe 'GET /' do
      it 'does not return homepage' do
        get root_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'when logged in' do
    describe 'GET /' do
      it 'returns homepage' do
        get root_path, headers: http_auth_headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
