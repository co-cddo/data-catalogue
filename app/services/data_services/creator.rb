# frozen_string_literal: true

module DataServices
  class Creator < BaseService
    def initialize(name:, url:, organisation_name:, optional: {})
      @name = name
      @url = url
      @organisation_name = organisation_name
      @optional = optional
    end

    def call
      DataService.find_or_create_by(name: @name, url: @url, organisation_id: organisation&.id) do |service|
        service.contact = contact || nil
        service.description = description || nil
        service.documentation_url = documentation_url || nil
        service.source = source
      end
    end

    private

    def contact
      @optional&.dig(:contact)
    end

    def description
      @optional&.dig(:description)
    end

    def documentation_url
      @optional&.dig(:documentation_url)
    end

    def organisation
      return if @organisation_name.blank?

      @organisation ||= Organisation.find_or_create_by(name: @organisation_name.squish)
    end

    def source
      source_id = @optional&.dig(:source_id)
      @source ||= Source.find(source_id) if source_id
    end
  end
end
