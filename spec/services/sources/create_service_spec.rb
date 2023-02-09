# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sources::CreateService do
  describe '#call' do
    let(:organisation) { create(:organisation) }

    context 'when with the same organisation' do
      before do
        source_one = described_class.call(name: 'Source One',
                                          url: Faker::Internet.url,
                                          organisation_name: organisation.name)
        source_two = described_class.call(name: 'Source Two',
                                          url: Faker::Internet.url,
                                          organisation_name: organisation.name)
        end

      it 'doesn\'t duplicate the organisation' do
        expect(Organisation.count).to eq(1)
      end

      it 'saves the sources' do
        expect(Source.count).to eq(2)
      end
    end

    context 'when with unnormalized url' do
      it 'normalizes the url' do
        source = described_class.call(name: 'Source One',
                                      url: 'https://localhost/api/foo/../?',
                                      organisation_name: organisation.name)
        expect(source.url).to eq('https://localhost/api/')
      end
    end
  end
end