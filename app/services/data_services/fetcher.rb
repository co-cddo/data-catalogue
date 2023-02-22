# frozen_string_literal: true

module DataServices
  class Fetcher < BaseService
    def initialize(query:, filters:)
      @query = query
      @filters = filters
    end

    def call
      data_services.order('name ASC')
    end

    private

    def data_services
      scope = DataService.includes(:organisation)
      scope = apply_filter(scope) if @filters.present?
      scope = apply_search(scope) if @query.present?
      scope
    end

    def apply_filter(scope)
      scope.where(organisation_id: @filters)
    end

    def apply_search(scope)
      scope.search(@query)
    end
  end
end
