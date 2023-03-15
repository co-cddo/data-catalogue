# frozen_string_literal: true

class RemoveNotNullConstraintFromDataServices < ActiveRecord::Migration[7.0]
  def change
    change_column_null :data_services, :organisation_id, true
    change_column_null :data_services, :name, true
    change_column_null :data_services, :url, true
  end
end
