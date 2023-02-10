# frozen_string_literal: true

require 'rails_helper'

class FakeService < BaseService
  def initialize(arg1:, arg2:)
    @arg1 = arg1
    @arg2 = arg2
  end

  def call
    @arg1 + @arg2
  end
end

RSpec.describe BaseService do
  describe '#call' do
    let(:arg1) { 123 }
    let(:arg2) { 345 }
    let(:result) { arg1 + arg2 }

    it 'instantiates the object correctly' do
      expect(FakeService.call(arg1:, arg2:)).to eq(result)
    end
  end
end
