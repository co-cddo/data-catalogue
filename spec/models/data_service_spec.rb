# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataService do
  describe 'associations' do
    it { is_expected.to have_one(:data_resource) }
    it { is_expected.to have_one(:publisher) }
    it { is_expected.to have_many(:creators) }
    it { is_expected.to have_many(:related_resources) }
  end
end
