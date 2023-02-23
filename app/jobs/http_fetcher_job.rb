# frozen_string_literal: true

class HttpFetcherJob < ApplicationJob
  queue_as :data_service

  # rubocop:disable Metrics/AbcSize
  def perform(source_id:)
    source = Source.find(source_id)
    content = fetch_source(url: source.url)
    JSON.parse(content.body)['apis'].each do |json|
      service = insert_service(json:, source_id: source.id)
      Rails.logger.info("Data Service #{service.name} from #{source.name} created")
    end
    Rails.logger.info("#{source.data_services.count} data services have been imported from #{source.name}")
  end
  # rubocop:enable Metrics/AbcSize

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

  def insert_service(json:, source_id:)
    DataServices::Creator.call(
      name: json['data']['name'],
      url: json['data']['url'],
      organisation_name: json['data']['organisation'],
      optional: {
        description: json['data']['description'],
        documentation_url: json['data']['documentation-url'],
        source_id:
      }
    )
  end
end
