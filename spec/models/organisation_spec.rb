# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation do
  context 'associations' do
    it { should have_many(:data_services).class_name('DataService') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end