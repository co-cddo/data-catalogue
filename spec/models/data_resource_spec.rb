# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataResource do
  subject(:data_resource) { build(:data_resource) }

  let(:organisations) { create_list(:organisation, 2) }
  let(:related_data_resources) { create_list(:data_resource, 2) }

  describe 'associations' do
    it { is_expected.to belong_to(:resourceable) }
    it { is_expected.to belong_to(:publisher) }
    it { is_expected.to have_many(:creations) }
    it { is_expected.to have_many(:creators) }
    it { is_expected.to have_many(:related_resources) }
    it { is_expected.to have_many(:related_data_resources) }
  end

  context 'when registering creators' do
    it 'registers organisations' do
      data_resource.creators = organisations
      expect(data_resource.creators).to eq(organisations)
    end
  end

  context 'when registering related data resources' do
    it 'registers data resources' do
      data_resource.related_data_resources = related_data_resources
      expect(data_resource.related_data_resources).to eq(related_data_resources)
    end
  end
end
