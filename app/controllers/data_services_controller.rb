# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @pagy, @data_services = pagy(DataServices::Fetcher.call(query: params[:query], filters: params[:filters]))
    @organisations = Organisation.where.not(name: nil).id_name_order_ASC
  end

  def show
    @data_service = DataService.includes(:data_resource, :publisher, :creators).find(params[:id])
  end
end
