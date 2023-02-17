# frozen_string_literal: true

class AddKindToSource < ActiveRecord::Migration[7.0]
  def change
    add_column :sources, :kind, :integer, null: false, default: 0
  end
end
