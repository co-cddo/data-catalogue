# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/data_services' do
  # rubocop:disable RSpec/VariableName
  let(:Authorization) { "Basic #{Base64.strict_encode64(creds)}" }
  # rubocop:enable RSpec/VariableName
  let(:creds) { "#{ENV.fetch('HTTP_USERNAME')}:#{ENV.fetch('HTTP_PASSWORD')}" }
  let(:required_params) do
    JSON.parse(Rails.root.join('spec/fixtures/data_service.json').read)
  end

  path '/api/v1/data_services' do
    post('create data service') do
      operationId 'post_data_service'
      description 'Creates a new data service'
      consumes 'application/json'
      produces 'application/json'
      security [basic_auth: []]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          data_service: {
            type: :object,
            properties: {
              enpointUrl: { type: :string, format: :url },
              endpointDescription: { type: :string },
              servesData: { type: :string },
              serviceType: { type: :string, enum: %w[EVENT REST SOAP] },
              serviceStatus: { type: :string, enum:
                %w[ALPHA BETA PRIVATE_BETA PUBLIC_BETA PRODUCTION DEPRECATED WITHDRAWN] },
              identifier: { type: :string },
              title: { type: :string },
              description: { type: :string },
              keywords: { type: :array, items: { type: :string } },
              themes: { type: :array, items: { type: :string } },
              licence: { type: :string },
              version: { type: :string },
              contactName: { type: :string },
              contactEmail: { type: :string, format: :email },
              alternativeTitle: { type: :array, items: { type: :string } },
              accessRights: { type: :string, enum: %w[INTERNAL OPEN COMMERCIAL] },
              securityClassification: { type: :string, enum:
                %w[OFFICIAL OFFICIAL_SENSITIVE SECRET TOP_SECRET] },
              issued: { type: :string, format: :date },
              modified: { type: :string, format: :datetime },
              creators: { type: :array, items: { type: :string, format: :uuid } },
              publisher: { type: :string, format: :uuid },
              relatedDataResources: { type: :array, items: { type: :string } },
              summary: { type: :string },
              created: { type: :string, format: :date }
            },
            required: %i[
              endpointDescription serviceStatus contactName contactEmail version accessRights
              securityClassification creator publisher description identifier licence modified title
            ]
          }
        },
        required: %i[data_service]
      }

      response(201, :created) do
        let(:params) { required_params }

        run_test!
      end

      response(422, :unprocessable_entity) do
        let(:params) do
          required_params['data_service'].delete('licence')
          required_params
        end

        run_test!
      end
    end
  end
end
