# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = data_services
    @organisations_checkbox_list = Organisation.all()
    @organisations = data_services.collect(&:organisation).uniq
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    # if reset button is pressed, return only search results (if query is present)
    return SearchService.call(query: params[:query]) if params[:reset] 
  
    # if apply filters button is pressed return filtered results 
    return SearchService.call(query: params[:query], filters: params[:filters]) if params[:apply]
  
    # if params[:query] is present return search results 
    return SearchService.call(query: params[:query]) if !params[:query].blank?
  
    # Else return all results
    DataService.all
  end
end


