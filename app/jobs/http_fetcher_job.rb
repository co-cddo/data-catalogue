# frozen_string_literal: true

class HttpFetcherJob < ApplicationJob
  queue_as :data_service

  SCHEMA_PATH = Rails.root.join('app/schemas/cddo-data-resources-schema.json').freeze

  def perform(source_id:)
    source = Source.find(source_id)
    content = fetch_source(url: source.url)
    output, status = JsonValidator.call(json: content.body, schema_path: SCHEMA_PATH)
    raise JsonValidator::ValidationError, output unless status.success?

    JSON.parse(content.body)['apis'].each { |json| insert_service(json:, source_id: source.id) }
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

  # rubocop:disable Metrics/MethodLength
  def insert_service(json:, source_id:)
    DataServices::Creator.call(
      name: json['data']['name'],
      url: json['data']['url'],
      organisation_name: json['data']['organisation'],
      optional: {
        description: json['data']['description'],
        documentation_url: json['data']['documentation-url'],
        contact: json['data']['contact'],
        source_id:
      }
    )
  end
  # rubocop:enable Metrics/MethodLength
end
