# frozen_string_literal: true

class DataServicesController < ApplicationController
  def show
    @data_service = DataService.find(params["id"])
  end
  def index
    @organisations = Organisation.includes(:data_services).all
  end
end
        


    end
end