# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @pagy, @data_services = pagy(DataResources::Fetcher.call(query: params[:query], filters: params[:filters]))
    @organisations = Organisation.where.not(name: nil).id_name_slug_order_asc
  end

  def show
    @data_resource = DataResource.find(params[:id])
    @data_service = @data_resource.resourceable
  end
end
