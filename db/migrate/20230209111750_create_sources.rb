class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources, id: :uuid do |t|
      t.text :name, null: false
      t.text :url, null: false
      t.timestamps

      t.references :organisation, type: :uuid, foreign_key: true, null: false
      t.index :url, unique: true
    end

    remove_reference :data_services, :organisation
    add_reference :data_services, :source, type: :uuid, null: false
  end
end
