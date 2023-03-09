# frozen_string_literal: true

class CreateDataResources < ActiveRecord::Migration[7.0]
  def change
    create_table :data_resources, id: :uuid do |t|
      t.text :identifier
      t.text :title
      t.text :description
      t.text :keywords, array: true, default: []
      t.text :theme
      t.text :license
      t.text :version
      t.text :contact_name
      t.text :contact_email
      t.text :alternative_title
      t.integer :access_rights
      t.integer :security_classification
      t.date :issued
      t.datetime :modified

      t.references :creator, null: true, type: :uuid, foreign_key: { to_table: :organisations }
      t.references :publisher, null: true, type: :uuid, foreign_key: { to_table: :organisations }

      t.timestamps
    end
  end
end
