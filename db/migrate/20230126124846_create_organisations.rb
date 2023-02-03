# frozen_string_literal: true

class CreateOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations, id: :uuid do |t|
      t.text :name, unique: true, null: false

      t.timestamps
    end

    add_reference :data_services, :organisation, type: :uuid, foreign_key: true
  end
end
