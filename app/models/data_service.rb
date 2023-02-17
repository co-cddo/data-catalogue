# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :organisation
  belongs_to :source, optional: true

  validates :name, :url, presence: true

  include PgSearch::Model

  pg_search_scope :search,
                  against: { name: 'A', description: 'B' },
                  associated_against: { organisation: { name: 'C' } },
                  using: { tsearch: { dictionary: 'english' } }
end
