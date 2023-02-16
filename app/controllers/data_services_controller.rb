# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = data_services
    @organisations_checkbox_list = Organisation.select(%i[id name])
  end

  def show
    @data_service = DataService.find(params[:id])
  end

  private

  def data_services
    @data_services = if params[:query].blank? && params[:filters].blank?
                       DataService.includes(:organisation).all.order('name ASC')
                     else
                       FilterService.call(query: params[:query], filters: params[:filters])
                     end
  end
end
