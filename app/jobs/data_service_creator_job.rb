# frozen_string_literal: true

class DataServiceCreatorJob < ApplicationJob
  queue_as :data_service

  SCHEMA_PATH = Rails.root.join('app/schemas/cddo-data-resource-schema.json').freeze

  def perform(json:, source_id:)
    output, status = JsonValidator.call(json:, schema_path: SCHEMA_PATH)
    raise JsonValidator::ValidationError, output unless status.success?

    insert_service(json:, source_id:)
  end

  private

  # rubocop:disable Metrics/MethodLength
  def insert_service(json:, source_id:)
    DataServices::Creator.call(
      name: json['name'],
      url: json['url'],
      organisation_name: json['organisation'],
      optional: {
        description: json['description'],
        documentation_url: json['documentation-url'],
        contact: json['contact'],
        source_id:
      }
    )
  end
  # rubocop:enable Metrics/MethodLength
end
