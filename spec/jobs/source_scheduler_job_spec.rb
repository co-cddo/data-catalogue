# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SourceSchedulerJob do
  include ActiveJob::TestHelper
  
  context 'when no sources are active' do
    before do
      create_list(:source, 2, active: false)
    end

    it 'does not enqueue any job' do
      described_class.perform_now
      expect(HttpFetcherJob).not_to have_been_enqueued
    end
  end

  context 'when sources are active' do
    before do
      create_list(:source, 2)
    end

    it 'does enqueue jobs' do
      described_class.perform_now
      expect(HttpFetcherJob).to have_been_enqueued.exactly(:twice)
    end
  end
end
