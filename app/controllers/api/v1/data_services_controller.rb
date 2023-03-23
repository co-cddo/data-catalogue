# frozen_string_literal: true

module Api
  module V1
    class DataServicesController < ApplicationController
      wrap_parameters format: [:json]
      protect_from_forgery with: :null_session

      def create
        data_service_form = DataServiceForm.new(data_service_params)
        if data_service_form.submit
          render json: { data_service: data_service_form.data_service }, status: :created
        else
          render json: { errors: data_service_form.errors }, status: :unprocessable_entity
        end
      end

      protected

      def data_service_params
        params.require(:data_service).permit!
      end
    end
  end
end
