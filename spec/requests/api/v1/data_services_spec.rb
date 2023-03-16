require 'swagger_helper'

RSpec.describe 'api/v1/data_services', type: :request do

  path '/api/v1/data_services' do

    post('create data service') do
      operationId 'post_data_service'
      description 'Creates a new data service'
      consumes 'application/json'
      produces 'application/json'

      response(201, :created) do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
