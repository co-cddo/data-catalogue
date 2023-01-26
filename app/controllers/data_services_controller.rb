class DataServicesController < ApplicationController
    def index 
        @data_services = DataService.all
    end 
end 