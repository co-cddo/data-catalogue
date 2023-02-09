# frozen_string_literal: true

class SearchService < BaseService
  def initialize(query: nil, filters: nil)
    @query = query
    @filters = filters
  end

  def call
    data_services = DataService.includes(:organisation)

    data_services = data_services.where(query, query: "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%") if @query.present?
    data_services = data_services.where(filters, filters: "%#{ActiveRecord::Base.sanitize_sql_like(@filters)}%") if @filters.present?

    data_services.order('organisations.name DESC')
  end

  private

  def query
    <<~SQL.squish
      data_services.name ILIKE :query OR#{' '}
      data_services.description ILIKE :query OR#{' '}
      organisations.name ILIKE :query
    SQL
  end

  def filters
    <<~SQL.squish
      organisations.name ILIKE :filters
    SQL
  end
end
