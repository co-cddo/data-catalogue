# frozen_string_literal: true

module DataResources
  class Fetcher < BaseService
    def initialize(query:, filters:)
      @query = query
      @filters = filters
    end

    def call
      data_resources.order('title ASC')
    end

    private

    def data_resources
      scope = DataResource.includes(:publisher, :resourceable)
      scope = apply_filter(scope) if @filters.present?
      scope = apply_search(scope) if @query.present?
      scope
    end

    def apply_filter(scope)
      scope.where(publisher_id: @filters)
    end

    def apply_search(scope)
      scope.search(@query)
    end
  end
end
