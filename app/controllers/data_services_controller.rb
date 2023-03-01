require 'json'
# frozen_string_literal: true

class DataServicesController < ApplicationController
  def index
    @data_services = DataServices::Fetcher.call(query: params[:query], filters: params[:filters])
    @organisations = Organisation.select(%i[id name]).order('name ASC')


    json_data = File.read('manual-organisations.json')
    data = JSON.parse(json_data)
    @organisations_json = data['results']
    @min_dept = []
    @non_min_dept = []
    @exec_non_dept_pb = []
    @exec_agency = []
    @other_dept = []
    
    @organisations_json.each do |organisation|
      case organisation['format']
      when 'Ministerial department'
        @min_dept << organisation
      when 'Non-ministerial department'
        @non_min_dept << organisation
      when 'Executive non-departmental public body'
        @exec_non_dept_pb << organisation
      when 'Executive agency'
        @exec_agency << organisation
      when 'Other'
        @other_dept << organisation
      end
    end
  end

  def show
    @data_service = DataService.includes(:organisation).find(params[:id])
  end

end
