# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilterService do
  describe '#call' do
    subject(:filtered_results) { described_class.call(query:, filters:) }

    context 'when query and filters are empty' do
      let(:query) { '' }
      let(:filters) { '' }

      it 'returns empty' do
        expect(filtered_results).to be_empty
      end

      it 'returns the correct number of results' do
        expect(filtered_results.count).to eq(0)
      end
    end

    # Search tests
    context 'when query is present' do
      context 'when searching for the service name' do
        let(:query) { 'relevant service' }
        let(:filters) { '' }
        let(:name) { 'Relevant Service 1' }

        before do
          create_list(:data_service, 5)
          create(:data_service, name:)
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect(&:name)).to all(match(/#{query}/i))
        end
      end

      context 'when searching for the service description' do
        let(:query) { 'relevant service' }
        let(:description) { 'Relevant Service 1' }
        let(:filters) { '' }

        before do
          create_list(:data_service, 5)
          create(:data_service, description:)
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect(&:description)).to all(match(/#{query}/i))
        end
      end

      context 'when searching for the organisation name' do
        let(:query) { 'relevant organisation' }
        let(:relevant_organisation) { create(:organisation, name: 'Relevant Organisation') }
        let(:filters) { '' }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation: relevant_organisation)
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect { |ds| ds.organisation.name }).to all(match(/#{query}/i))
        end
      end

      # Filtering tests
      context 'when one filter is present' do
        let(:organisation_one) { create(:organisation) }
        let(:filter_organisation_ids) { [organisation_one.id] }
        let(:filters) { filter_organisation_ids }
        let(:query) { '' }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation_id: organisation_one.id)
        end

        it 'returns the correct results' do
          results = filtered_results.collect { |ds| ds.organisation.id }
          expect(results).to contain_exactly(*filter_organisation_ids)
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end
      end
    end

    context 'when two filters are present' do
      let(:organisation_one) { create(:organisation) }
      let(:organisation_two) { create(:organisation) }
      let(:filter_organisation_ids) { [organisation_one.id, organisation_two.id] }
      let(:filters) { filter_organisation_ids }
      let(:query) { '' }

      before do
        create_list(:data_service, 5)
        create(:data_service, organisation: organisation_one)
        create(:data_service, organisation: organisation_two)
      end

      it 'returns the correct results' do
        results = filtered_results.collect { |ds| ds.organisation.id }
        expect(results).to contain_exactly(*filter_organisation_ids)
      end

      it 'returns the correct number of results' do
        expect(filtered_results.count).to eq(2)
      end
    end

    context 'when two filters are present but three organisations are in the db' do
      let(:organisation_one) { create(:organisation) }
      let(:organisation_two) { create(:organisation) }
      let(:organisation_three) { create(:organisation) }
      let(:filters) { [organisation_one.id, organisation_two.id] }
      let(:query) { '' }

      before do
        create_list(:data_service, 5)
        create(:data_service, organisation_id: organisation_one.id)
        create(:data_service, organisation_id: organisation_two.id)
        create(:data_service, organisation_id: organisation_three.id)
      end

      it 'returns the correct results' do
        results = filtered_results.collect { |ds| ds.organisation.id }
        expect(results).to contain_exactly(*filters)
      end

      it 'returns the correct number of results' do
        expect(filtered_results.count).to eq(2)
      end
    end

    # Filter & Search combination
    context 'when both a filter and a search are present' do
      context 'when searching for a service name and filtering for an organisation' do
        let(:organisation_one) { create(:organisation, name: 'Test Organisation') }
        let(:filters) { [organisation_one.id] }
        let(:query) { 'API' }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation_id: organisation_one.id, name: 'Test API')
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect(&:name)).to all(match(/#{query}/i))
        end

        it 'returns the correct organisation' do
          results = filtered_results.collect { |ds| ds.organisation.id }
          expect(results).to contain_exactly(*filters)
        end
      end

      context 'when searching for a service description and filtering for an organisation' do
        let(:organisation_one) { create(:organisation, name: 'Test Organisation') }
        let(:filters) { [organisation_one.id] }
        let(:query) { 'test description' }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation_id: organisation_one.id, description: 'This is a test description')
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect(&:description)).to all(match(/#{query}/i))
        end

        it 'returns the correct organisation' do
          results = filtered_results.collect { |ds| ds.organisation.id }
          expect(results).to contain_exactly(*filters)
        end
      end

      context 'when searching for a service organisation and filtering for an organisation' do
        let(:organisation_one) { create(:organisation, name: 'Test Organisation') }
        let(:filters) { [organisation_one.id] }
        let(:query) { 'Test Organisation' }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation_id: organisation_one.id)
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect { |ds| ds.organisation.name }).to all(match(/#{query}/i))
        end

        it 'returns the correct organisation' do
          results = filtered_results.collect { |ds| ds.organisation.id }
          expect(results).to contain_exactly(*filters)
        end
      end

      context 'when searching for a service name and filtering for multiple organisations' do
        let(:organisation_one) { create(:organisation, name: 'Test Organisation 1') }
        let(:organisation_two) { create(:organisation, name: 'Test Organisation 2') }
        let(:filters) { [organisation_one.id, organisation_two.id] }
        let(:query) { 'API' }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation_id: organisation_one.id, name: 'Test API 1')
          create(:data_service, organisation_id: organisation_two.id, name: 'Test API 2')
        end

        it 'returns the correct number of results' do
          expect(filtered_results.count).to eq(2)
        end

        it 'returns the correct results' do
          expect(filtered_results.collect(&:name)).to all(match(/#{query}/i))
        end

        it 'returns the correct organisation' do
          results = filtered_results.collect { |ds| ds.organisation.id }
          expect(results).to contain_exactly(*filters)
        end
      end
    end
  end
end
