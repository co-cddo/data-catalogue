# frozen_string_literal: true

class DataResource < ApplicationRecord
  belongs_to :resourceable, polymorphic: true
  belongs_to :publisher, class_name: 'Organisation'
  has_many :creations, dependent: :destroy
  has_many :creators, through: :creations, class_name: 'Organisation', source: :organisation
  has_many :related_resources, dependent: :destroy
  has_many :related_data_resources, through: :related_resources, class_name: 'DataResource'

  enum :access_rights, { INTERNAL: 0, OPEN: 1, COMMERCIAL: 2 }
  enum :security_classification, { OFFICIAL: 0, SECRET: 1, TOP_SECRET: 2 }
end
