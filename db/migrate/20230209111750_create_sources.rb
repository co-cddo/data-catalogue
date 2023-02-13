# frozen_string_literal: true

class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources, id: :uuid do |t|
      t.text :name, null: false
      t.text :url, null: false
      t.timestamps

      t.index :url, unique: true
    end

    add_reference :data_services, :source, type: :uuid
  end
end
