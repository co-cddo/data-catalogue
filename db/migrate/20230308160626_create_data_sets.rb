# frozen_string_literal: true

class CreateDataSets < ActiveRecord::Migration[7.0]
  def change
    create_table :data_sets, id: :uuid do |t|
      t.belongs_to :data_resource

      t.timestamps
    end
  end
end
