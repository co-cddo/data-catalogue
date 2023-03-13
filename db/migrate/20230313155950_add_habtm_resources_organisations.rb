# frozen_string_literal: true

class AddHabtmResourcesOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations_resources, id: false do |t|
      t.belongs_to :organisation, type: :uuid, null: false
      t.belongs_to :resource, type: :uuid, null: false

      t.timestamps

      t.index %i[organisation_id resource_id], name: 'index_organisations_resources_on_org_id_and_res_id', unique: true
    end
  end
end
