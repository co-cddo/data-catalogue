# frozen_string_literal: true

class CreateCreations < ActiveRecord::Migration[7.0]
  def change
    create_table :creations, id: false do |t|
      t.belongs_to :organisation, type: :uuid, null: false
      t.belongs_to :data_resource, type: :uuid, null: false

      t.timestamps

      t.index %i[organisation_id data_resource_id], unique: true
    end
  end
end
