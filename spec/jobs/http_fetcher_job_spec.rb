# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpFetcherJob do
  # Handles sources of http kind by downloading and parsing the JSON at
  # the endpoint and insert the data_services into the database.

  include ActiveJob::TestHelper

  let(:source_url) { 'http://example.com/apis' }
  let(:source) { create(:source, url: source_url) }
  let(:response_body) { Rails.root.join('db/seeds/fsa.json').read }

  context 'when json validates' do
    let(:success_status) { instance_double(Process::Status, success?: true) }

    before do
      stub_request(:get, source_url)
        .to_return(status: 200, body: response_body, headers: {})
      allow(JsonValidator).to receive(:call).and_return(['', success_status])
    end

    it 'saves the right number of services' do
      described_class.perform_now(source_id: source.id)

      expect(DataServiceCreatorJob).to have_been_enqueued.exactly(:twice)
    end
  end

  context 'when json does not validate' do
    let(:failed_status) { instance_double(Process::Status, success?: false) }

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
