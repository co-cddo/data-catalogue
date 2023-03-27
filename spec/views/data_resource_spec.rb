# frozen_string_literal: true

# spec/views/data_resources/data_resource.html.erb_spec.rb

require 'rails_helper'

RSpec.describe 'data_resources' do
  let(:summary_text) { Faker::Company.bs }
  let(:description_text) { Faker::Lorem.paragraph }
  let(:data_resource_one) { create(:data_resource, summary: summary_text) }
  let(:data_resource_two) { create(:data_resource, summary: nil, description: description_text) }

  describe 'displays correct description' do
    context 'when summary is present' do
      it 'returns summary' do
        result = (data_resource_one.summary.presence || data_resource_one.description&.truncate(250))
        expect(result).to eq(data_resource_one.summary)
      end
    end

    context 'when summary is not present' do
      it 'returns truncated description' do
        result = (data_resource_two.summary.presence || data_resource_two.description&.truncate(250))
        expect(result).to eq(data_resource_two.description.truncate(250))
      end
    end
  end
end
