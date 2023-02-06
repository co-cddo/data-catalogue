# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataService do
  describe 'associations' do
    it { should belong_to(:organisation).class_name('Organisation') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:organisation_id) }
  end
end
