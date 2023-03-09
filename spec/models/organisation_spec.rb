# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation do
  subject { create(:organisation) }

  describe 'associations' do
    it { is_expected.to have_many(:data_services) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

  describe '#create' do
    context 'when without slug' do
      let(:organisation) { described_class.new(name: 'NHS Digital', slug: nil) }

      it 'sets a slug using SLUGS' do
        organisation.save
        expect(organisation.reload.slug).to eq('nhs-digital')
      end
    end

    context 'when slug is present' do
      let(:organisation) { described_class.new(name: 'New Agency', slug: 'new-agency') }

      it 'does not change it' do
        expect(organisation.slug).to eq('new-agency')
      end
    end
  end
end
