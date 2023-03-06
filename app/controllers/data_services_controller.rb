# frozen_string_literal: true

require 'json'

class DataServicesController < ApplicationController
  def index
    @data_services = DataServices::Fetcher.call(query: params[:query], filters: params[:filters])
    @organisations = Organisation.select(%i[id name]).order('name ASC')
  end

  def show
    @data_service = DataService.includes(:organisation).find(params[:id])
  end
end
