# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpFetcherJob do
  # Handles sources of http kind by downloading and parsing the JSON at
  # the endpoint and insert the data_services into the database.

  include ActiveJob::TestHelper

  let(:source_url) { 'http://example.com/apis' }
  let(:source) { create(:source, url: source_url) }
  let(:response_body) { Rails.root.join('db/seeds/fsa.json').read }
  let(:success_status) { instance_double(Process::Status, success?: true) }
  let(:failed_status) { instance_double(Process::Status, success?: false) }

  context 'when json validates' do
    before do
      stub_request(:get, source_url)
        .to_return(status: 200, body: response_body, headers: {})
      allow(JsonValidator).to receive(:call).and_return(['', success_status])
    end

    it 'saves the right number of services' do
      expect do
        described_class.perform_now(source_id: source.id)
      end.to change(DataService, :count).by(2)
    end
  end

  context 'when json does not validate' do
    before do
      stub_request(:get, source_url)
        .to_return(status: 200, body: response_body, headers: {})
      allow(JsonValidator).to receive(:call).and_return(['', failed_status])
    end

    it 'saves the right number of services' do
      expect do
        described_class.perform_now(source_id: source.id)
      end.to raise_error(JsonValidator::ValidationError)
    end
  end
end
