# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Source do
  subject(:source) { create(:source) }

  describe 'associations' do
    it { is_expected.to have_many(:data_resources) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
  end

  describe '.active' do
    before do
      create_list(:source, 5, active: false)
      create(:source, active: true)
    end

    it 'returns correct number of actives' do
      expect(described_class.active.count).to eq(1)
    end
  end

  describe '.inactive' do
    before do
      create_list(:source, 5)
      create(:source, active: false)
    end

    it 'returns correct number of inactives' do
      expect(described_class.inactive.count).to eq(1)
    end
  end
end
