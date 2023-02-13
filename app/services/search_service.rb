# frozen_string_literal: true

class SearchService < BaseService
  def initialize(query:, filters:)
    @query = query
    @filters = filters
  end

  def call
    data_services = DataService.includes(:organisation)
    data_services = filter(data_services) if @filters.present?
    data_services = search(data_services) if @query.present?
    data_services.order('organisations.name ASC')
  end

  private

  def filter(data_services)
    data_services.where(organisation_id: @filters)
  end

  def search(data_services)
    data_services.where(query,
                        query: "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%")
  end

  def query
    <<~SQL.squish
      data_services.name ILIKE :query OR#{' '}
      data_services.description ILIKE :query OR#{' '}
      organisations.name ILIKE :query
    SQL
  end
end
