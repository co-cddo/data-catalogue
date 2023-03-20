# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = DataServices::Fetcher.call(query: params[:query], filters: params[:filters]).where.not(name: nil)
    @organisations = Organisation.where.not(name: nil).id_name_order_ASC
  end

  def show
    @data_service = DataService.includes(:organisation).find(params[:id])
  end
end
