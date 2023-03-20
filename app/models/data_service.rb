# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :organisation, optional: true
  belongs_to :source, optional: true
  has_one :data_resource, as: :resourceable, dependent: :destroy

  enum :service_type, { EVENT: 0, REST: 1, SOAP: 2 }
  enum :status, { ALPHA: 0, BETA: 1, PRIVATE_BETA: 2, PUBLIC_BETA: 3,
                  PRODUCTION: 4, DEPRECATED: 5, WITHDRAWN: 6 }

  include PgSearch::Model
  pg_search_scope :search,
                  against: { name: 'A', description: 'B' },
                  associated_against: { organisation: { name: 'C' } },
                  using: { tsearch: { prefix: true, dictionary: 'english' } }

  def name
    read_attribute(:name) || data_resource&.title
  end
end
