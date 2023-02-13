# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    params.delete(:filters) if params[:reset].present?
    @data_services = data_services
    @organisations_checkbox_list = Organisation.all
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    @data_services = DataService.includes(:organisation).all
    @data_services = SearchService.call(query: params[:query]) if params[:query].present?
    if params[:filters].present?
      @data_services = FilterService.call(filters: params[:filters], data_services: @data_services)
    end
    @data_services
  end
end
