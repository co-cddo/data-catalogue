# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = data_services
    @organisations_checkbox_list = Organisation.select([:id, :name])
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    if params[:query].blank? && params[:filters].blank?
      @data_services = DataService.includes(:organisation).all.order('name ASC')
    else
      @data_services = SearchService.call(query: params[:query], filters: params[:filters])
    end
  end
end
