# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataResources::Fetcher do
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
      context 'when searching for the resource title' do
        let(:query) { 'relevant resource' }
        let(:filters) { '' }
        let(:title) { 'Relevant Resource 1' }

        before do
          create_list(:data_resource, 5)
          create(:data_resource, title:)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect(&:title)).to all(match(/#{query}/i))
        end
      end

      context 'when searching for the resource description' do
        let(:query) { 'relevant resource' }
        let(:description) { 'Relevant Resource 1' }
        let(:filters) { '' }

        before do
          create_list(:data_resource, 5)
          create(:data_resource, description:)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect(&:description)).to all(match(/#{query}/i))
        end
      end

      context 'when searching for the resource summary' do
        let(:query) { 'relevant resource' }
        let(:summary) { 'Relevant resource 1' }
        let(:filters) { '' }

        before do
          create_list(:data_resource, 5)
          create(:data_resource, summary:)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect(&:summary)).to all(match(/#{query}/i))
        end
      end

      context 'when searching for the organisation name' do
        let(:query) { 'relevant organisation' }
        let(:relevant_organisation) { create(:organisation, name: 'Relevant Organisation') }
        let(:filters) { '' }

        before do
          create_list(:data_resource, 5)
          create(:data_resource, publisher: relevant_organisation)
        end

        it 'returns the correct number of results' do
          expect(search_results.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search_results.collect { |ds| ds.publisher.name }).to all(match(/#{query}/i))
        end
      end

      # Filtering tests
      context 'when one filter is present' do
        let(:organisation_one) { create(:organisation) }
        let(:filter_organisation_ids) { [organisation_one.id] }
        let(:filters) { filter_organisation_ids }
        let(:query) { '' }

        before do
          create_list(:data_resource, 5)
          create(:data_resource, publisher_id: organisation_one.id)
        end

        it 'returns the correct results' do
          results = search_results.collect { |ds| ds.publisher.id }
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
        create_list(:data_resource, 5)
        create(:data_resource, publisher: organisation_one)
        create(:data_resource, publisher: organisation_two)
      end

      it 'returns the correct results' do
        results = search_results.collect { |ds| ds.publisher.id }
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
        create_list(:data_resource, 5)
        create(:data_resource, publisher: organisation_one)
        create(:data_resource, publisher: organisation_two)
        create(:data_resource, publisher: organisation_three)
      end

      it 'returns the correct results' do
        results = search_results.collect { |ds| ds.publisher.id }
        expect(results).to contain_exactly(*filters)
      end

      it 'returns the correct number of results' do
        expect(search_results.count).to eq(2)
      end
    end
  end
end
