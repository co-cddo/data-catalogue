# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelatedResource do
  describe 'associations' do
    it { is_expected.to belong_to(:data_resource) }
    it { is_expected.to belong_to(:related_data_resource) }
  end
end
