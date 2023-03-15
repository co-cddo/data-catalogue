# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DataServiceForm' do
  subject(:data_service_form) { DataServiceForm.new(params) }

  let(:organisations) { create_list(:organisation, 2) }

  context 'when successful' do
    let(:required_params) do
      {
        endpoint_description: 'Example service',
        status: 'BETA',
        contact_name: 'John Doe',
        contact_email: 'john@example.com',
        version: 1,
        access_rights: 'OPEN',
        security_classification: 'OFFICIAL_SENSITIVE',
        creators: organisations.collect(&:slug),
        publisher: organisations.last.slug,
        description: 'Example service',
        identifier: 'ABC123XYZ',
        license: 'https://opensource.org/license/mit/',
        modified: 2.days.ago,
        title: 'Example service'
      }
    end

    context 'with required params' do
      let(:params) { required_params }

      it 'is valid' do
        expect(data_service_form).to be_valid
      end

      it 'adds a data service' do
        expect { data_service_form.submit }.to change(DataService, :count).by(1)
      end

      it 'adds a data resource' do
        expect { data_service_form.submit }.to change(DataResource, :count).by(1)
      end
    end

    context 'with optional params' do
      let(:related_data_resources) { create_list(:data_resource, 2) }
      let(:params) do
        required_params.merge(
          {
            endpoint_url: 'https://example.com/endpoint',
            serves_data: [
              'https://description_one.local',
              'https://description_two.local'
            ],
            service_type: 'EVENT',
            keywords: %w[one two],
            themes: %w[theme_one theme_two],
            summary: 'Example service summary',
            issued: Time.zone.today,
            related_data_resources: related_data_resources.collect(&:id),
            alternative_titles: [
              'Alternative example service 1',
              'Alternative example service 2'
            ],
            created: 2.days.ago
          }
        )
      end

      it 'is valid' do
        expect(data_service_form).to be_valid
      end

      it 'adds a data service' do
        expect { data_service_form.submit }.to change(DataService, :count).by(3)
      end

      it 'adds a data resource' do
        expect { data_service_form.submit }.to change(DataResource, :count).by(3)
      end
    end
  end
end
