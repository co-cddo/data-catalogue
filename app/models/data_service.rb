# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :organisation, optional: true
  has_one :data_resource, as: :resourceable, dependent: :destroy
  has_many :creators, through: :data_resource
  has_one :publisher, through: :data_resource
  has_many :related_resources, through: :data_resource

  enum :service_type, { EVENT: 0, REST: 1, SOAP: 2 }
  enum :service_status, { DISCOVERY: 0, ALPHA: 1, BETA: 2, PRIVATE_BETA: 3,
                          PUBLIC_BETA: 4, LIVE: 5, DEPRECATED: 6, WITHDRAWN: 7 }
end
