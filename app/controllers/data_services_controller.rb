# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = data_services
    @organisations_checkboxes = Organisation.all()
    @organisations = data_services.collect(&:organisation).uniq
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    # if reset button is pressed, return only search results (if query is present)
    return SearchService.call(query: params[:query]) if params[:reset] && params[:query].present?
  
    # return filtered results if apply filters button is pressed
    return SearchService.call(query: params[:query], filters: params[:filters]) if params[:apply]
  
    # return search results if params[:query] is present but filter is blank
    return SearchService.call(query: params[:query]) if params[:query].present? && params[:filters].blank?
  
    # if query and filter are blank, return all results
    DataService.all
  end
end


