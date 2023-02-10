# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Source do
  subject(:source) { create(:source) }

  describe 'associations' do
    it { is_expected.to have_many(:data_services) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
  end
end
