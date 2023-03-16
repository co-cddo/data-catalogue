# frozen_string_literal: true

class DataServiceForm
  include ActiveModel::Model

  attr_accessor :endpoint_url, :endpoint_description, :serves_data, :service_type, :status, :identifier, :title,
                :description, :keywords, :themes, :licence, :version, :contact_name, :contact_email,
                :alternative_titles, :access_rights, :security_classification, :issued, :modified, :creators,
                :publisher, :related_data_resources, :summary, :created, :data_service, :data_resource

  validates :endpoint_description, :status, :contact_name, :contact_email, :version, :access_rights,
            :security_classification, :creators, :publisher, :description, :identifier, :licence, :modified,
            :title, presence: true

  def initialize(params = {})
    super(params)

    @data_service = build_data_service
    @data_resource = build_data_resource
  end

  def submit
    return false if invalid?

    DataResource.transaction do
      data_resource.save
    end
  end

  private

  def build_data_service
    DataService.new(endpoint_url:, endpoint_description:, serves_data:, service_type:, status:)
  end

  # rubocop:disable Metrics/AbcSize
  def build_data_resource
    DataResource.new(contact_name:, contact_email:, keywords:, themes:, version:, access_rights:,
                     security_classification:, creators: _creators, description:, summary:,
                     identifier:, issued:, licence:, modified:, publisher: _publisher, title:,
                     alternative_titles:, created:, related_data_resources: _related_data_resources,
                     resourceable: data_service)
  end
  # rubocop:enable Metrics/AbcSize

  def _creators
    creators.collect { |slug| Organisation.find_or_create_by(slug:) }
  end

  def _publisher
    Organisation.find_or_create_by(slug: publisher)
  end

  def _related_data_resources
    return [] if related_data_resources.blank?

    related_data_resources.collect { |id| DataResource.find(id) }
  end
end
