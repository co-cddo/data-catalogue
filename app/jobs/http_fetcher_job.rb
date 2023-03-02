# frozen_string_literal: true

class HttpFetcherJob < ApplicationJob
  queue_as :data_service

  SCHEMA_PATH = Rails.root.join('app/schemas/cddo-data-resources-schema.json').freeze

  def perform(source_id:)
    source = Source.find(source_id)
    content = fetch_source(url: source.url)
    output, status = JsonValidator.call(json: content.body, schema_path: SCHEMA_PATH)
    raise JsonValidator::ValidationError, output unless status.success?

    JSON.parse(content.body)['apis'].each do |data|
      DataServiceCreatorJob.perform_later(json: data['data'].to_json, source_id: source.id)
    end
  end

  private

  def request(url:)
    @request ||= Faraday.new(url:) do |f|
      f.response :json
      f.adapter :http
    end
  end

  def fetch_source(url:)
    destination = Addressable::URI.parse(url)
    request(url: "#{destination.scheme}://#{destination.host}").get(destination.path)
  end
end
