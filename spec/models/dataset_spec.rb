# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dataset do
  describe 'associations' do
    it { is_expected.to have_one(:data_resource) }
  end
end
