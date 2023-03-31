# frozen_string_literal: true

module Api
  module V1
    class DataServicesController < ApplicationController
      wrap_parameters format: [:json]
      protect_from_forgery with: :null_session

      rescue_from Exception, with: :handle_bad_request

      DATA_SERVICE_PARAMS = [
        :endpoint_url, :endpoint_description, :serves_data, :service_type, :service_status,
        :identifier, :title, :description, :licence, :version, :contact_name, :contact_email,
        :access_rights, :security_classification, :issued, :modified, :created, :publisher, :summary,
        { alternative_titles: [], creators: [], keywords: [], related_data_resources: [], themes: [] }
      ].freeze

      def create
        data_service_form = DataServiceForm.new(data_service_params)
        if data_service_form.submit
          render json: { data_service: { id: data_service_form.data_service.id } }, status: :created
        else
          render json: { errors: data_service_form.errors }, status: :unprocessable_entity
        end
      end

      private

      def data_service_params
        params.require(:data_service).permit(DATA_SERVICE_PARAMS)
      end

      def handle_bad_request(exception)
        render json: { error: exception.message }, status: :bad_request
      end
    end
  end
end
