# frozen_string_literal: true

class AddSlugToOrganisations < ActiveRecord::Migration[7.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_column :organisations, :slug, :string, null: false
    # rubocop:enable Rails/NotNullColumn
    add_index :organisations, :slug, unique: true
  end
end
