# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @organisations = Organisation.includes(:data_services).all
  end

  def show
    @data_service = DataService.find(params[:id])
  end
end
