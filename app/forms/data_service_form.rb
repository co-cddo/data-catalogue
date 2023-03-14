# frozen_string_literal: true

class DataServiceForm
  include ActiveModel::Model

  attr_accessor :endpoint_url, :endpoint_description, :serves_data, :service_type, :status, :identifier, :title,
                :description, :keywords, :theme, :license, :version, :contact_name, :contact_email, :alternative_title,
                :access_rights, :security_classification, :issued, :modified, :creator, :publisher, :related_resources,
                :summary, :created

  validates :endpoint_description, :status, :contact_name, :contact_email, :version, :access_rights,
            :security_classification, :creator, :publisher, :description, :identifier, :license, :modified,
            :title, presence: true

  def submit
    DataService.transaction do
      data_service.save
      data_resource.save
    end
  end

  private

  def data_service
    @data_service ||= DataService.new(endpoint_url:, endpoint_description:, serves_data:, service_type:, status:)
  end

  # rubocop:disable Metrics/AbcSize
  def data_resource
    @data_resource ||= DataResource.new(contact_name:, contact_email:, keywords:, theme:, version:, access_rights:,
                                        security_classification:, creator: _creators, description:, summary:,
                                        identifier:, issued:, license:, modified:, publisher: _publisher, title:,
                                        alternative_title:, created:, resourceable: data_service)
  end
  # rubocop:enable Metrics/AbcSize

  def _creators
    creator.collect { |slug| Organisation.find_by(slug: slug) }
  end

  def _publisher
    Organisation.find_by(slug: publisher)
  end
end
