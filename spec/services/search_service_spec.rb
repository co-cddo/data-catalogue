# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService do
  describe '#call' do
    subject(:search) { described_class.call(query:) }

    context 'when query is empty' do
      let(:query) { '' }

      it 'returns empty' do
        expect(search).to be_empty
      end
    end

    context 'when query is present' do
      context 'when on the service name' do
        let(:query) { 'relevant service' }
        let(:name) { 'Relevant Service 1' }

        before do
          create_list(:data_service, 5)
          create(:data_service, name:)
        end

        it 'returns the correct number of results' do
          expect(search.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search.collect(&:name)).to all(match(/#{query}/i))
        end
      end

      context 'when on the service description' do
        let(:query) { 'relevant service' }
        let(:description) { 'Relevant Service 1' }

        before do
          create_list(:data_service, 5)
          create(:data_service, description:)
        end

        it 'returns the correct number of results' do
          expect(search.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search.collect(&:description)).to all(match(/#{query}/i))
        end
      end

      context 'when on the organisation name' do
        let(:query) { 'relevant organisation' }
        let(:relevant_organisation) { create(:organisation, name: 'Relevant Organisation') }

        before do
          create_list(:data_service, 5)
          create(:data_service, organisation: relevant_organisation)
        end

        it 'returns the correct number of results' do
          expect(search.count).to eq(1)
        end

        it 'returns the correct results' do
          expect(search.collect { |ds| ds.organisation.name }).to all(match(/#{query}/i))
        end
      end
    end
  end
end
