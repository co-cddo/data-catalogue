# frozen_string_literal: true

class DataServiceForm
  include ActiveModel::Model

  attr_accessor :endpoint_url, :endpoint_description, :serves_data, :status, :identifier, :title, :description,
                :keywords, :theme, :license, :version, :contact_name, :contact_email, :alternative_title,
                :access_rights, :security_classification, :issued, :modified, :creators_slugs, :publisher_slug,
                :related_resources

  validates :endpoint_description, :status, :contact_name, :contact_email, :version, :access_rights,
            :security_classification, :creators_slugs, :publisher, :description, :identifier, :license, :modified,
            :title, presence: true

  def submit
    DataService.transaction do
      data_service.save
    end
  end

  private

  def data_service
    @data_service ||= DataService.new(endpoint_url:, endpoint_description:,
                                      serves_data:, status:, data_resource:)
  end

  # rubocop:disable Metrics/AbcSize
  def data_resource
    @data_resource ||= DataResource.new(contact_name:, contact_email:, keyword:, theme:, version:, access_rights:,
                                        security_classification:, creators:, description:, summary:, identifier:,
                                        issued:, license:, modified:, publisher:, title:, alternative_title:, created:)
  end
  # rubocop:enable Metrics/AbcSize

  def creators
    creators.collect do |slug|
      Organisation.find_by(slug)
    end
  end

  def publisher
    @publisher ||= Organisation.find_by(publisher)
  end
end
