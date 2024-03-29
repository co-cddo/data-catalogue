# frozen_string_literal: true

class CreateDataResources < ActiveRecord::Migration[7.0]
  def change
    create_table :data_resources, id: :uuid do |t|
      t.text :alternative_titles, array: true, default: []
      t.text :contact_name
      t.text :contact_email
      t.text :description
      t.text :identifier
      t.text :keywords, array: true, default: []
      t.text :licence
      t.text :summary
      t.text :themes, array: true, default: []
      t.text :title
      t.text :version
      t.integer :access_rights
      t.integer :security_classification
      t.date :issued
      t.datetime :created
      t.datetime :modified

      t.references :resourceable, polymorphic: true, type: :uuid, null: false
      t.references :publisher, null: true, type: :uuid, foreign_key: { to_table: :organisations }

      t.timestamps
    end
  end
end
