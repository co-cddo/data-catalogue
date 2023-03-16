# frozen_string_literal: true

module Api
  module V1
    class DataServicesController < ApplicationController
      protect_from_forgery with: :null_session

      KEYS = {
        'accessRights' => 'access_rights',
        'creator' => 'creators',
        'contactEmail' => 'contact_email',
        'contactName' => 'contact_name',
        'endpointDescription' => 'endpoint_description',
        'keyword' => 'keywords',
        'relatedDataResources' => 'related_data_resources',
        'securityClassification' => 'security_classification',
        'servesData' => 'serves_data',
        'serviceStatus' => 'status',
        'serviceType' => 'service_type',
        'theme' => 'themes'
      }.freeze

      def create
        data_service_form = DataServiceForm.new(data_service_params)
        if data_service_form.submit
          render json: { data_service: data_service_form.data_service }, status: 201
        else
          render json: { errors: data_service_form.errors }, status: 422
        end
      end

      protected

      def data_service_params
        transformed_params.require(:data_service).permit!
      end

      def transformed_params
        params.deep_transform_keys! do |key|
          KEYS.key?(key) ? KEYS[key] : key
        end
      end
    end
  end
end
