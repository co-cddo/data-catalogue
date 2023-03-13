# frozen_string_literal: true

class ChangeDataService < ActiveRecord::Migration[7.0]
  def change
    change_table :data_services, bulk: true do |t|
      t.text :endpoint_url
      t.text :endpoint_description
      t.integer :serves_data
      t.integer :status
    end
  end
end
