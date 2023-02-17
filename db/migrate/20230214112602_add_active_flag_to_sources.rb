# frozen_string_literal: true

class AddActiveFlagToSources < ActiveRecord::Migration[7.0]
  def change
    add_column :sources, :active, :bool, null: false, default: true
    add_index :sources, :active
  end
end
