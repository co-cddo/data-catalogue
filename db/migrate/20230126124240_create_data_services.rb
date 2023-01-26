# frozen_string_literal: true

class CreateDataServices < ActiveRecord::Migration[7.0]
  def change
    create_table :data_services do |t|
      t.text :name, null: false
      t.text :description
      t.text :url
      t.text :contact
      t.text :documentation_url

      t.timestamps
    end
  end
end
