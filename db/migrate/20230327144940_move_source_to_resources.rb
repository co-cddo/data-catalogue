# frozen_string_literal: true

class MoveSourceToResources < ActiveRecord::Migration[7.0]
  def change
    add_reference :data_resources, :source, type: :uuid
    remove_reference :data_services, :source
  end
end
