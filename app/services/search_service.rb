class SearchService < BaseService
  def initialize(q:)
    @q = q
  end

  def call
    DataService.joins(:organisation).where(query, q: "%#{ActiveRecord::Base.sanitize_sql_like(@q)}%")
  end

  private

  def query
    <<~SQL.squish
    data_services.name ILIKE :q OR 
    data_services.description ILIKE :q OR 
    organisations.name ILIKE :q
    SQL
  end
end