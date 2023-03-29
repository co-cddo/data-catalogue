# frozen_string_literal: true

class HttpFetcherJob < ApplicationJob
  queue_as :data_service

  def perform(source_id:)
    source = Source.find(source_id)
    content = fetch_source(url: source.url)
    JSON.parse(content.body)['data_services'].each { |json| insert_resource(json:, source_id: source.id) }
    Rails.logger.info("#{source.data_resources.count} data resources have been imported from #{source.name}")
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

  def insert_resource(json:, source_id:)
    form = DataServiceForm.new(json)
    form.data_resource.source_id = source_id
    form.submit
  end
end
