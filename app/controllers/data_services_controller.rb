# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = DataService.all
    @organisations = Organisation.all
    query = params[:query]
    if query.present?
      results = DataService.joins(:organisation)
      .where("data_services.name ILIKE :query OR data_services.description ILIKE :query 
        OR organisations.name ILIKE :query", query: "%#{query}%")
      @data_services = results
    end
  end

  def show
    @data_service = DataService.find(params[:id])
  end
end
