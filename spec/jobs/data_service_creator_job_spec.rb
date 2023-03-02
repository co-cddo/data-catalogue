# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataServiceCreatorJob do
  # Handles sources of http kind by downloading and parsing the JSON at
  # the endpoint and insert the data_services into the database.

  include ActiveJob::TestHelper

  let(:source) { create(:source) }
  let(:json_collection) { JSON.parse(Rails.root.join('db/seeds/fsa.json').read) }
  let(:json) { json_collection['apis'].first.to_json }

  context 'when json validates' do
    let(:success_status) { instance_double(Process::Status, success?: true) }

    before do
      allow(JsonValidator).to receive(:call).and_return(['', success_status])
    end

    it 'saves the right number of services' do
      expect do
        described_class.perform_now(json:, source_id: source.id)
      end.to change(DataService, :count).by(1)
    end
  end

  context 'when json does not validate' do
    let(:failed_status) { instance_double(Process::Status, success?: false) }

    before do
      allow(JsonValidator).to receive(:call).and_return(['', failed_status])
    end

    it 'raises the right exception' do
      expect do
        described_class.perform_now(json:, source_id: source.id)
      end.to raise_error(JsonValidator::ValidationError)
    end
  end
end
