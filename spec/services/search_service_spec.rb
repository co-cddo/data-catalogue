# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService do
  subject(:search_results) { described_class.call(query: query, filters: filters) }

  describe '#call' do
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


    context 'when filter and query are nil' do
      let(:filters) {nil}
      let(:query) {nil}
      before do
        create_list(:data_service, 5)
        create(:data_service, name: 'Relevant Service 1')
        create(:data_service, name: 'Relevant Service 2')
      end
      
      it 'returns whole list of unfiltered results' do
        expect(search_results.count).to eq(7)
      end
    end

    # Primarily search tests where filters = nil
    context 'when query is present' do
      context 'when searching for the service name' do
        let(:query) { 'relevant service' }
        let(:filters) {nil}

        before do
          create_list(:data_service, 5)
          create(:data_service, name: 'Relevant Service 1')
          create(:data_service, name: 'Relevant Service 2')
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(2)
        end

        it 'returns the correct results' do
          expect(search_results.collect(&:name)).to all(match(/#{query}/i))
        end
      end
    end

    context 'when searching for the service description' do
      let(:query) { 'relevant service' }
      let(:filters) {nil}

      before do
        create_list(:data_service, 5)
        create(:data_service, description: 'Relevant Service 1')
        create(:data_service, description: 'Relevant Service 2')
      end

      it 'returns the correct number of results' do
        expect(search_results.count).to eq(2)
      end

      it 'returns the correct results' do
        expect(search_results.collect(&:description)).to all(match(/#{query}/i))
      end
    end

    context 'when searching for the organisation name' do
      let(:query) { 'relevant organisation' }
      let(:filters) {nil}

      before do
        create_list(:data_service, 5)
        organisation = create(:organisation, name: 'Relevant Organisation')
        create(:data_service, organisation:)
        create(:data_service, organisation:)
      end

      it 'returns the correct number of results' do
        expect(search_results.count).to eq(2)
      end

      it 'returns the correct results' do
        expect(search_results.collect { |ds| ds.organisation.name }).to all(match(/#{query}/i))
      end
    end

    # Primarily filtering functionality where query = nil
    context 'when one filter is present' do
      context 'when on the organisation id' do
        let(:filters) { ['e4063f05-26ec-4b36-97f1-18760c9beb4d'] }
        let(:query) {nil}

        before do
          create_list(:data_service, 5)
          organisation_one = create(:organisation, id: 'e4063f05-26ec-4b36-97f1-18760c9beb4d')
          create(:data_service, organisation: organisation_one)
        end

        it 'returns the correct results' do
          expect(search_results.collect { |ds| ds.organisation.id }).to all(satisfy do |id|
                                                                                      filters.include?(id)
                                                                                    end)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(1)
        end
      end
    end

    context 'when two filters are present' do
      context 'when on the organisation id' do
        let(:filters) { %w[e4063f05-26ec-4b36-97f1-18760c9beb4d 5bcef76b-3cda-4836-8a77-77f229a1a449] }
        let(:query) {nil}

        before do
          create_list(:data_service, 5)
          organisation_one = create(:organisation, id: 'e4063f05-26ec-4b36-97f1-18760c9beb4d')
          organisation_two = create(:organisation, id: '5bcef76b-3cda-4836-8a77-77f229a1a449')
          create(:data_service, organisation: organisation_one)
          create(:data_service, organisation: organisation_two)
        end

        it 'returns the correct results' do
          expect(search_results.collect { |ds| ds.organisation.id }).to all(satisfy do |id|
                                                                                      filters.include?(id)
                                                                                    end)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(2)
        end
      end
    end

    context 'when two filters are present but three organisations are in the db' do
      context 'when on the organisation id' do
        let(:filters) { %w[e4063f05-26ec-4b36-97f1-18760c9beb4d 5bcef76b-3cda-4836-8a77-77f229a1a449] }
        let(:query) {nil}

        before do
          create_list(:data_service, 5)
          organisation_one = create(:organisation, id: 'e4063f05-26ec-4b36-97f1-18760c9beb4d')
          organisation_two = create(:organisation, id: '5bcef76b-3cda-4836-8a77-77f229a1a449')
          organisation_three = create(:organisation, id: 'e90935bf-fac2-4a15-8e6c-95c2f42ed3aa')
          create(:data_service, organisation: organisation_one)
          create(:data_service, organisation: organisation_two)
          create(:data_service, organisation: organisation_three)
        end

        it 'returns the correct results' do
          expect(search_results.collect { |ds| ds.organisation.id }).to all(satisfy do |id|
                                                                                      filters.include?(id)
                                                                                    end)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(2)
        end
      end
    end
  end
end
