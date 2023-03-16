require 'swagger_helper'

RSpec.describe 'api/v1/data_services', type: :request do

  path '/api/v1/data_services' do

    post('create data service') do
      operationId 'post_data_service'
      description 'Creates a new data service'
      consumes 'application/json'
      produces 'application/json'
      security [ basic_auth: [] ]
      parameter name: :data_service, in: :body, schema: {
        type: :object,
        properties: {
          enpointUrl: { type: :string },
          endpointDescription: { type: :string },
          servesData: { type: :string },
          serviceType: { type: :string, enum: ['EVENT', 'REST', 'SOAP'] },
          serviceStatus: { type: :string, enum: 
            ['ALPHA', 'BETA', 'PRIVATE_BETA', 'PUBLIC_BETA', 'PRODUCTION', 'DEPRECATED', 'WITHDRAWN'] },
          identifier: { type: :string },
          title: { type: :string },
          description: { type: :string },
          keywords: { type: :array, items: { type: :string } },
          theme: { type: :string },
          licence: { type: :string },
          version: { type: :string },
          contactName: { type: :string },
          contactEmail: { type: :string },
          alternativeTitle: { type: :string },
          accessRights: { type: :string, enum: ['INTERNAL', 'OPEN', 'COMMERCIAL'] },
          securityClassification: { type: :string, enum:
            ['OFFICIAL', 'OFFICIAL_SENSITIVE', 'SECRET', 'TOP_SECRET'] },
          issued: { type: :string },
          modified: { type: :string },
          creator: { type: :array, items: { type: :string } },
          publisher: { type: :string },
          relatedDataResources: { type: :array, items: { type: :string } },
          summary: { type: :string },
          created: { type: :string }
        },
        required: %i[ 
          endpointDescription serviceStatus contactName contactEmail version accessRights 
          securityClassification creator publisher description identifier licence modified title 
        ]
      }


      response(201, :created) do
        let(:Authorization) { "Basic #{::Base64.strict_encode64(creds)}" }
        let(:creds) { "#{ENV.fetch('HTTP_USERNAME')}:#{ENV.fetch('HTTP_PASSWORD')}"}
        let(:data_service) do
          JSON.parse(File.read(Rails.root.join('spec/fixtures/data_service.json')))
        end

        run_test!
      end
    end
  end
end