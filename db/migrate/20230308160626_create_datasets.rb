# frozen_string_literal: true

class CreateDatasets < ActiveRecord::Migration[7.0]
  def change
    create_table :datasets, id: :uuid, &:timestamps
  end
end
