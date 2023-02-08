# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = data_services
    @organisations = data_services.collect(&:organisation).uniq
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    return DataService.all if params[:query].blank?
    return DataService.all if params[:reset]
    SearchService.call(query: params[:query])
  end
end
