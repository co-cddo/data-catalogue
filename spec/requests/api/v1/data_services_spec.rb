# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/data_services' do
  # rubocop:disable RSpec/VariableName
  let(:Authorization) { "Basic #{Base64.strict_encode64(creds)}" }
  # rubocop:enable RSpec/VariableName
  let(:creds) { "#{ENV.fetch('HTTP_USERNAME')}:#{ENV.fetch('HTTP_PASSWORD')}" }
  let(:required_params) do
    JSON.parse(Rails.root.join('spec/fixtures/data_service_required_params.json').read)
  end
  let(:all_params) do
    JSON.parse(Rails.root.join('spec/fixtures/data_service_all_params.json').read)
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
              endpoint_url: { type: :string, format: :url },
              endpoint_description: { type: :string },
              serves_data: { type: :array, items: { type: :string, format: :url } },
              service_type: { type: :string, enum: %w[EVENT REST SOAP] },
              service_status: { type: :string, enum:
                %w[DISCOVERY ALPHA BETA PRIVATE_BETA PUBLIC_BETA LIVE DEPRECATED WITHDRAWN] },
              identifier: { type: :string },
              title: { type: :string },
              description: { type: :string },
              keywords: { type: :array, items: { type: :string } },
              themes: { type: :array, items: { type: :string } },
              licence: { type: :string, format: :url },
              version: { type: :string },
              contact_name: { type: :string },
              contact_email: { type: :string, format: :email },
              alternative_titles: { type: :array, items: { type: :string } },
              access_rights: { type: :string, enum: %w[INTERNAL OPEN COMMERCIAL] },
              security_classification: { type: :string, enum:
                %w[OFFICIAL SECRET TOP_SECRET] },
              issued: { type: :string, format: :date },
              modified: { type: :string, format: :datetime },
              creators: { type: :array, items: { type: :string } },
              publisher: { type: :string },
              related_data_resources: { type: :array, items: { type: :string, format: :uuid } },
              summary: { type: :string },
              created: { type: :string, format: :date }
            },
            required: %i[
              endpoint_description service_status contact_name contact_email version access_rights
              security_classification creator publisher description identifier licence modified title
            ]
          }
        },
        required: %i[data_service]
      }

      response(201, :created) do
        let(:params) { required_params }

        run_test!
      end

      response(201, :created) do
        let(:params) { all_params }

        run_test!
      end

      response(201, :created) do
        let(:params) do
          required_params['data_service']['not_a_real_field'] = 'abc'
          required_params
        end

        run_test!
      end

      response(422, :unprocessable_entity) do
        let(:params) do
          required_params['data_service'].delete('licence')
          required_params
        end

        run_test!
      end

      response(400, :bad_request) do
        let(:params) { { identifier: 'abc' } }

        run_test!
      end
    end
  end
end
