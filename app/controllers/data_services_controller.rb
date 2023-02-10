# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    if params[:reset].present?
      params.delete(:filters)
    end
    @data_services = data_services
    @organisations_checkbox_list = Organisation.all()
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    @data_services = DataService.includes(:organisation).all
    if params[:query].present?
      @data_services = SearchService.call(query: params[:query])
    end
    if params[:filters].present?
      @data_services = FilterService.call(filters: params[:filters], data_services: @data_services)
    end
    @data_services
  end
end


