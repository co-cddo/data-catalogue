# frozen_string_literal: true

class AddHabtmResourcesOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :data_resources_organisations, id: false do |t|
      t.belongs_to :organisation, type: :uuid, null: false
      t.belongs_to :data_resource, type: :uuid, null: false

      t.timestamps

      t.index %i[organisation_id data_resource_id], name: 'index_organisations_resources_on_org_id_and_res_id', unique: true
    end
  end
end
