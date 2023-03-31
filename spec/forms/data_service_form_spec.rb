# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DataServiceForm' do
  subject(:data_service_form) { DataServiceForm.new(params) }

  let(:required_params) do
    {
      endpoint_description: 'Example service',
      service_status: 'BETA',
      contact_name: 'John Doe',
      contact_email: 'john@example.com',
      version: 1,
      access_rights: 'OPEN',
      security_classification: 'OFFICIAL',
      creators: organisations.collect(&:slug),
      publisher: organisations.last.slug,
      description: 'Example service',
      identifier: 'ABC123XYZ',
      licence: 'https://opensource.org/license/mit/',
      modified: 2.days.ago,
      title: 'Example service'
    }
  end
  let(:organisations) { create_list(:organisation, 2) }

  context 'when valid' do
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

      it 'saves related resources' do
        data_service_form.submit
        expect(data_service_form.data_resource.related_data_resources.count).to eq(2)
      end
    end

    context 'with invalid related resources' do
      let(:params) do
        required_params.merge(
          {
            related_data_resources: ['1234-abcd-4321-dcba']
          }
        )
      end

      it 'is valid' do
        expect(data_service_form).to be_valid
      end

      it 'removes invalid resources' do
        data_service_form.submit
        expect(data_service_form.data_resource.related_data_resources).to be_empty
      end
    end
  end

  context 'when invalid' do
    context 'when data service is invalid' do
      let(:params) { required_params.except(:endpoint_description) }

      it 'does not validate' do
        expect(data_service_form).not_to be_valid
      end

      it 'returns the errors' do
        data_service_form.submit
        expect(data_service_form.errors.include?(:endpoint_description)).to be(true)
      end

      it 'does not save the data resource' do
        expect { data_service_form.submit }.not_to change(DataResource, :count)
      end
    end

    context 'when creators or related_data_resources are not arrays' do
      let(:params) do
        required_params.merge(creators: 'invalid_creator')
      end

      it 'does not validate' do
        expect(data_service_form).not_to be_valid
      end

      it 'returns the errors for creators' do
        data_service_form.submit
        expect(data_service_form.errors[:creators]).to include('must be an array')
      end

      it 'does not save the data resource' do
        expect { data_service_form.submit }.not_to change(DataResource, :count)
      end
    end

    context 'when data resource is invalid' do
      let(:params) { required_params.except(:licence) }

      it 'does not validate' do
        expect(data_service_form).not_to be_valid
      end

      it 'returns the errors' do
        data_service_form.submit
        expect(data_service_form.errors.include?(:licence)).to be(true)
      end

      it 'does not save the data service' do
        expect { data_service_form.submit }.not_to change(DataService, :count)
      end
    end
  end
end
