# frozen_string_literal: true

class DataResource < ApplicationRecord
  belongs_to :resourceable, polymorphic: true
  belongs_to :publisher, class_name: 'Organisation'
  has_and_belongs_to_many :creator, class_name: 'Organisation'
  has_and_belongs_to_many :related_resources, 
    class_name: 'DataResource', 
    join_table: :related_resources, 
    foreign_key: :data_resource_id, 
    association_foreign_key: :related_date_resource_id

  enum :access_rights, { INTERNAL: 0, OPEN: 1, COMMERCIAL: 2 }
  enum :security_classification, { OFFICIAL: 0, OFFICIAL_SENSITIVE: 1, SECRET: 2, TOP_SECRET: 3 }
end
