# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpFetcherJob do
  # Handles sources of http kind by downloading and parsing the JSON at
  # the endpoint and insert the data_services into the database.

  include ActiveJob::TestHelper

  let(:source_url) { 'http://example.com/apis' }
  let(:source) { create(:source, url: source_url) }
  let(:response_body) { Rails.root.join('db/seeds.json').read }

  before do
    stub_request(:get, source_url)
      .to_return(status: 200, body: response_body, headers: {})
  end

  it 'saves the right number of resources' do
    expect do
      described_class.perform_now(source_id: source.id)
    end.to change(DataResource, :count).by(4)
  end
end
