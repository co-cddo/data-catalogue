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
              identifier: {
                type: :string,
                description: 'A unique number, code, or reference value assigned to an information
                resource within a given context. Local identifier for the resource'
              },
              title: {
                type: :string,
                description: 'A name given to the resource'
              },
              alternative_titles: {
                type: :array,
                items: { type: :string },
                description: 'Alternative names for the data resource including common
                abbreviations and synonyms'
              },
              summary: {
                type: :string,
                description: 'A couple of sentences summarising the data resource'
              },
              description: {
                type: :string,
                description: 'A detailed description of the data resource'
              },
              keywords: {
                type: :array,
                items: { type: :string },
                description: 'Uncontrolled terms (words or phrases) assigned to describe an information resource'
              },
              themes: {
                type: :array,
                description:
                  'A controlled term that expresses a topic of the intellectual content of an information resource',
                items: { type: :string }
              },
              licence: {
                type: :string,
                format: :url,
                description:
                  'Reference to the legal document outlining access and usage rights for an information resource'
              },
              version: {
                type: :string,
                description: 'The version number of the data resource'
              },
              contact_name: {
                type: :string,
                description: 'Name of the point of contact or the team name'
              },
              contact_email: {
                type: :string,
                format: :email,
                description:
                  'Email address for the point of contact. Preferable a team email address'
              },
              access_rights: {
                type: :string,
                enum: %w[INTERNAL OPEN COMMERCIAL],
                description: 'Information about who can access the resource or an
                indication of its security status'
              },
              security_classification: {
                type: :string,
                enum: %w[OFFICIAL SECRET TOP_SECRET],
                description: 'An information security designation that identifies the
                minimum level of protection assigned to an information resource'
              },
              issued: {
                type: :string,
                format: :date,
                description: 'The date on which an information resource was originally
                published or otherwise made publicly available for the first time'
              },
              created: {
                type: :string,
                format: :date,
                description: 'Date of creation of the resource'
              },
              modified: {
                type: :string,
                format: :datetime,
                description: 'The date on which the content of an information resource is changed'
              },
              creators: {
                type: :array,
                items: { type: :string, format: :uri },
                description: 'The URI of the business entity responsible for creating or
                compiling the original content of an information resource'
              },
              publisher: {
                type: :string,
                format: :uri,
                description:
                  'The URI of the business entity responsible for making an information resource publicly available'
              },
              related_data_resources: {
                type: :array,
                description: 'A collection of ids for data resources that relate to the resource',
                items: { type: :string, format: :uuid }
              },
              endpoint_url: {
                type: :string,
                format: :url,
                description: 'The root location or primary endpoint of the service (a Web-resolvable IRI)'
              },
              endpoint_description: {
                type: :string,
                description:
                  'A web-resolvable IRI containing a description of the services available via
                  the end-points, including their operations, parameters etc'
              },
              serves_data: {
                type: :array,
                description: 'A collection of data that this data service can distribute',
                items: { type: :string, format: :url }
              },
              service_type: {
                type: :string,
                enum: %w[EVENT REST SOAP],
                description: 'The nature or genre of the resource'
              },
              service_status: {
                type: :string,
                description: 'The status of the resource in the context of a particular workflow process [VOCAB-ADMS]',
                enum:
                  %w[DISCOVERY ALPHA BETA PRIVATE_BETA PUBLIC_BETA LIVE DEPRECATED WITHDRAWN]
              }

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
