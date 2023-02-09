module Sources
  class CreateService < BaseService
    def initialize(name:, url:, organisation_name:)
      @name = name
      @url = url
      @organisation_name = organisation_name
    end

    def call
      Source.find_or_create_by(organisation: organisation, url: url) do |source|
        source.name = @name
      end
    end

    private

    def url
      Addressable::URI.parse(@url).normalize.to_s
    end

    def organisation
      Organisation.find_or_create_by(name: @organisation_name.squish)
    end
  end
end