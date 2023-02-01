# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = DataService.all
    if params[:query].present?
      @data_services = @data_services.where("name ILIKE ?", "%#{params[:query]}%").or(@data_services.where("description ILIKE ?", "%#{params[:query]}%"))
    end
  end

  def show
    @data_service = DataService.find(params[:id])
  end
end
