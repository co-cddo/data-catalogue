# frozen_string_literal: true

class DataServicesController < ApplicationController
  def show
    @data_service = DataService.includes(:creators, :publisher, data_resource: :related_resources).find(params[:id])
    @data_resource = @data_service.data_resource
  end
end
