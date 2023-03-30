# frozen_string_literal: true

class CleanupUnusedDataServiceFields < ActiveRecord::Migration[7.0]
  def change
    change_table :data_services, bulk: true do |t|
      t.remove :name, type: :string
      t.remove :description, type: :string
      t.remove :url, type: :string
      t.remove :contact, type: :string
      t.remove :documentation_url, type: :string
      t.remove :organisation_id, type: :uuid
    end
  end
end
