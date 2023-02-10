# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sources::CreateService do
  describe '#call' do
    let(:organisation) { create(:organisation) }

    context 'when with unnormalized url' do
      it 'normalizes the url' do
        source = described_class.call(name: 'Source One',
                                      url: 'https://localhost/api/foo/../?')
        expect(source.url).to eq('https://localhost/api/')
      end
    end
  end
end