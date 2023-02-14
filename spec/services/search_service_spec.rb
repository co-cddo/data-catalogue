# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService do
  describe '#call' do
    subject(:search_results) { described_class.call(query:, filters:) }

    context 'when query and filters are empty' do
      let(:query) { '' }
      let(:filters) { '' }

      it 'returns empty' do
        expect(search_results).to be_empty
      end

      it 'returns the correct number of results' do
        expect(search_results.count).to eq(0)
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
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect(&:name)).to all(match(/#{query}/i))
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
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect(&:description)).to all(match(/#{query}/i))
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
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect { |ds| ds.organisation.name }).to all(match(/#{query}/i))
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
          results = search_results.collect { |ds| ds.organisation.id }
          expect(results).to contain_exactly(*filter_organisation_ids)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(1)
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
        results = search_results.collect { |ds| ds.organisation.id }
        expect(results).to contain_exactly(*filter_organisation_ids)
      end

      it 'returns the correct number of results' do
        expect(search_results.count).to eq(2)
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
        results = search_results.collect { |ds| ds.organisation.id }
        expect(results).to contain_exactly(*filters)
      end

      it 'returns the correct number of results' do
        expect(search_results.count).to eq(2)
      end
    end
  end
end
