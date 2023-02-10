# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilterService do
  subject(:filtered_organisations) { described_class.call(filters:) }

  describe '#call' do
    context 'when filters are empty' do
      let(:filters) { [''] }

      it 'returns empty' do
        expect(filtered_organisations).to be_empty
      end
      it 'returns the correct number of results' do
        expect(filtered_organisations.count).to eq(0)
      end
    end

    context 'when one filter is present' do
      context 'when on the organisation id' do
        let(:filters) {[ 'e4063f05-26ec-4b36-97f1-18760c9beb4d'] }

        before do
          create_list(:data_service, 5)
          organisation_one = create(:organisation, id: 'e4063f05-26ec-4b36-97f1-18760c9beb4d')
          create(:data_service, organisation: organisation_one)
        end

        it 'returns the correct results' do
          expect(filtered_organisations.collect { |ds| ds.organisation.id }).to all(satisfy { |id| filters.include?(id) })
        end
        it 'returns the correct number of results' do
          expect(filtered_organisations.count).to eq(1)
        end
      end
    end


    context 'when two filters are present' do
      context 'when on the organisation id' do
        let(:filters) {[ 'e4063f05-26ec-4b36-97f1-18760c9beb4d', '5bcef76b-3cda-4836-8a77-77f229a1a449' ]}

        before do
          create_list(:data_service, 5)
          organisation_one = create(:organisation, id: 'e4063f05-26ec-4b36-97f1-18760c9beb4d')
          organisation_two = create(:organisation, id: '5bcef76b-3cda-4836-8a77-77f229a1a449')
          create(:data_service, organisation: organisation_one)
          create(:data_service, organisation: organisation_two)
        end

        it 'returns the correct results' do
          expect(filtered_organisations.collect { |ds| ds.organisation.id }).to all(satisfy { |id| filters.include?(id) })
        end
        it 'returns the correct number of results' do
          expect(filtered_organisations.count).to eq(2)
        end
      end
    end

    context 'when two filters are present but three organisations are in the db' do
      context 'when on the organisation id' do
        let(:filters) { ['e4063f05-26ec-4b36-97f1-18760c9beb4d', '5bcef76b-3cda-4836-8a77-77f229a1a449'] }

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
          expect(filtered_organisations.collect { |ds| ds.organisation.id }).to all(satisfy { |id| filters.include?(id) })
        end
        it 'returns the correct number of results' do
          expect(filtered_organisations.count).to eq(2)
        end
      end
    end
  end
end
