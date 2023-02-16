# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpFetcherJob do
  include ActiveJob::TestHelper

  let(:source) { create(:source, url: 'http://example.com/apis') }
  let(:response_body) { Rails.root.join('db/seeds/fsa.json').read }

  before do
    stub_request(:get, 'http://example.com/apis')
      .to_return(status: 200, body: response_body, headers: {})
  end

  it 'saves the right number of services' do
    expect do
      described_class.perform_now(source_id: source.id)
    end.to change(DataService, :count).by(2)
  end
end
