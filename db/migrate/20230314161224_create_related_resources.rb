# frozen_string_literal: true

class CreateRelatedResources < ActiveRecord::Migration[7.0]
  def change
    create_table :related_resources, id: false do |t|
      t.belongs_to :data_resource, type: :uuid, null: false
      t.belongs_to :related_data_resource, type: :uuid, null: false
      t.timestamps

      t.index %i[data_resource_id related_data_resource_id],
              unique: true,
              name: 'index_on_data_resource_id_and_related_data_resource_id'
      t.index %i[related_data_resource_id data_resource_id],
              unique: true,
              name: 'index_on_related_data_resource_id_and_data_resource_id'
    end
  end
end
