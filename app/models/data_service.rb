# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :organisation
  belongs_to :source, optional: true
  has_one :resource, as: :resourceable, dependent: :destroy

  validates :name, :url, presence: true

  enum :service_type, { event: 0, rest: 1, soap: 2 }
  enum :status, { alpha: 0, beta: 1, private_beta: 2, public_beta: 3,
                  production: 4, deprecated: 5, withdrawn: 6 }

  include PgSearch::Model
  pg_search_scope :search,
                  against: { name: 'A', description: 'B' },
                  associated_against: { organisation: { name: 'C' } },
                  using: { tsearch: { prefix: true, dictionary: 'english' } }
end
