# frozen_string_literal: true

class RelatedResource < ApplicationRecord
  belongs_to :data_resource
  belongs_to :related_data_resource, class_name: 'DataResource'
end
