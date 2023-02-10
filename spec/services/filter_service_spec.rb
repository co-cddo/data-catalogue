# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilterService do
  subject(:filter_organisations) { described_class.call(filters:) }

  describe '#call' do
    context 'when filters are empty' do
      let(:filters) { [''] }

      it 'returns empty' do
        expect(filter_organisations).to be_empty
      end
    end

    context 'when one filter is present' do
      context 'when on the organisation name' do
        let(:filters) { ['first organisation' ]}

        before do
          create_list(:data_service, 5)
          organisation = create(:organisation, name: 'first organisation')
          create(:data_service, organisation:)
          create(:data_service, organisation:)
        end

        it 'returns the correct results' do
          expect(filter_organisations.collect { |ds| ds.organisation.name }).to all(match(/#{filters}/i))
        end
      end
    end


    context 'when more than one filter is present' do
      context 'when on the organisation name' do
        let(:filters) { [ 'first organisation', 'second organisation'] }

        before do
          create_list(:data_service, 5)
          organisation_one = create(:organisation, name: 'first Organisation')
          organisation_two = create(:organisation, name: 'second organisation')
          create(:data_service, organisation: organisation_one)
          create(:data_service, organisation: organisation_one)
          create(:data_service, organisation: organisation_two)
          create(:data_service, organisation: organisation_two)
        end

        it 'returns the correct results' do
          expect(filter_organisations.collect { |ds| ds.organisation.name }).to all(match(/#{filters}/i))
        end
      end
    end
  end
end
