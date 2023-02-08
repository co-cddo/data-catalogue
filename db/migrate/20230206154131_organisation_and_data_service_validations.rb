# frozen_string_literal: true

class OrganisationAndDataServiceValidations < ActiveRecord::Migration[7.0]
  def change
    change_column_null :organisations, :name, false
    change_column_null :data_services, :name, false
    change_column_null :data_services, :url, false
    change_column_null :data_services, :organisation_id, false
  end
end
