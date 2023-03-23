# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :publisher, class_name: 'Organisation'
  belongs_to :source, optional: true
  has_one :data_resource, as: :resourceable, dependent: :destroy
  has_many :creators, through: :data_resource
  
  enum :service_type, { EVENT: 0, REST: 1, SOAP: 2 }
  enum :service_status, { DISCOVERY: 0, ALPHA: 1, BETA: 2, PRIVATE_BETA: 3,
                          PUBLIC_BETA: 4, LIVE: 5, DEPRECATED: 6, WITHDRAWN: 7 }

  include PgSearch::Model
  pg_search_scope :search,
                  against: { name: 'A', description: 'B' },
                  associated_against: { organisation: { name: 'C' } },
                  using: { tsearch: { prefix: true, dictionary: 'english' } }

  def name
    read_attribute(:name) || data_resource&.title
  end
end
