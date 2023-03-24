# frozen_string_literal: true

class ChangeDataServiceStatusField < ActiveRecord::Migration[7.0]
  def change
    rename_column :data_services, :status, :service_status
  end
end
