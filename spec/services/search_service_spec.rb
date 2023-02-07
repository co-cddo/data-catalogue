# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService do
  subject(:search) { described_class.call(query:) }

  describe '#call' do
    context 'when query is empty' do
      let(:query) { '' }

      it 'returns empty' do
        expect(search).to be_empty
      end
    end

    context 'when query is present' do
      context 'when on the service name' do
        let(:query) { 'relevant service' }

        before do
          create_list(:data_service, 5)
          create(:data_service, name: 'Relevant Service 1')
          create(:data_service, name: 'Relevant Service 2')
        end

        it 'returns the correct number of results' do
          expect(search.count).to eq(2)
        end

        it 'returns the correct results' do
          expect(search.collect(&:name)).to all(match(/#{query}/i))
        end
      end
    end

    context 'when on the service description' do
      let(:query) { 'relevant service' }

      before do
        create_list(:data_service, 5)
        create(:data_service, description: 'Relevant Service 1')
        create(:data_service, description: 'Relevant Service 2')
      end

      it 'returns the correct number of results' do
        expect(search.count).to eq(2)
      end

      it 'returns the correct results' do
        expect(search.collect(&:description)).to all(match(/#{query}/i))
      end
    end

    context 'when on the organisation name' do
      let(:query) { 'relevant organisation' }

      before do
        create_list(:data_service, 5)
        organisation = create(:organisation, name: 'Relevant Organisation')
        create(:data_service, organisation:)
        create(:data_service, organisation:)
      end

      it 'returns the correct number of results' do
        expect(search.count).to eq(2)
      end

      it 'returns the correct results' do
        expect(search.collect { |ds| ds.organisation.name }).to all(match(/#{query}/i))
      end
    end
  end
end
