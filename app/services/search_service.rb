# frozen_string_literal: true

class SearchService < BaseService
  def initialize(query:)
    @query = query
  end

  def call
    DataService.joins(:organisation).where(query, query: "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%")
  end

  private

  def query
    <<~SQL.squish
      data_services.name ILIKE :query OR#{' '}
      data_services.description ILIKE :query OR#{' '}
      organisations.name ILIKE :query
    SQL
  end
end
