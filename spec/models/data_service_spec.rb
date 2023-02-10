# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataService do
  describe 'associations' do
    it { is_expected.to belong_to(:organisation) }
    it { is_expected.to belong_to(:source).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
