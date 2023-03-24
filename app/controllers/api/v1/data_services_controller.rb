# frozen_string_literal: true

module Api
  module V1
    class DataServicesController < ApplicationController
      wrap_parameters format: [:json]
      protect_from_forgery with: :null_session

      rescue_from ActionController::ParameterMissing, with: :handle_bad_request
      rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_bad_request

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
        params.require(:data_service).permit(:endpoint_url, :endpoint_description, :serves_data, :service_type,
                                             :status, :identifier, :title, :description, :licence, :version,
                                             :contact_name, :contact_email, :access_rights, :security_classification,
                                             :issued, :modified, :created, :publisher, :summary, alternative_titles: [],
                                             creators: [], keywords: [], related_data_resources: [], themes: [])
      end

      def handle_bad_request(exception)
        render json: { error: exception.message }, status: :bad_request
      end
    end
  end
end
