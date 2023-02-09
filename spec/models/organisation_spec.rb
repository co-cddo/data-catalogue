# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation do
  describe 'associations' do
    it { is_expected.to have_many(:sources) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
