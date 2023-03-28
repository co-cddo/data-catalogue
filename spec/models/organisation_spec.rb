# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation do
  subject { create(:organisation) }

  describe 'associations' do
    it { is_expected.to have_many(:data_resources) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

  describe '#create' do
    context 'when without name' do
      let(:organisation) { described_class.new(slug: 'nhs-digital', name: nil) }

      it 'sets a name using NAMES' do
        organisation.save
        expect(organisation.reload.name).to eq('NHS Digital')
      end
    end

    context 'when name is present' do
      let(:organisation) { described_class.new(name: 'New Agency', slug: 'new-agency') }

      it 'does not change it' do
        expect(organisation.name).to eq('New Agency')
      end
    end
  end
end
