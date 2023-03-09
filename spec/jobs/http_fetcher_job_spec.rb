# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpFetcherJob do
  # Handles sources of http kind by downloading and parsing the JSON at
  # the endpoint and insert the data_services into the database.

  include ActiveJob::TestHelper

  let(:source_url) { 'http://example.com/apis' }
  let(:source) { create(:source, url: source_url) }
  let(:response_body) { Rails.root.join('spec/fixtures/source.json').read }
  let(:updated_response_body) { Rails.root.join('spec/fixtures/source_updated.json').read }

  before do
    stub_request(:get, source_url)
      .to_return(status: 200, body: response_body, headers: {})
  end

  it 'saves the right number of services' do
    expect do
      described_class.perform_now(source_id: source.id)
    end.to change(DataService, :count).by(1)
  end

  context 'when the resources were already imported' do
    before do
      described_class.perform_now(source_id: source.id)
    end

    it 'does not import them again' do
      expect do
        described_class.perform_now(source_id: source.id)
      end.not_to change(DataService, :count)
    end

    context 'when the resources have changed in the source' do
      before do
        stub_request(:get, source_url)
          .to_return(status: 200, body: updated_response_body, headers: {})
      end

      it 'updates the services' do
        expect do
          described_class.perform_now(source_id: source.id)
        end.to change(DataService.first, :description)
      end
    end
  end
end
