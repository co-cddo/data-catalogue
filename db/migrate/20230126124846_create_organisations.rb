class CreateOrganisations < ActiveRecord::Migration[7.0]
  def change
    create_table :organisations do |t|
      t.text :name, unique: true, null: false

      t.timestamps
    end

    add_reference :data_services, :organisation, index: true
  end
end
