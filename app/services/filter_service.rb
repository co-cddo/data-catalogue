class FilterService < BaseService
  def initialize(filters: nil, data_services: nil)
    @filters = filters
    @data_services = data_services
  end

  def call
    data_services = @data_services || DataService.includes(:organisation).all
    data_services = data_services.where(organisation_id: @filters) if @filters.present?
    data_services.order(name: :asc)
  end
end
