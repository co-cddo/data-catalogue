# frozen_string_literal: true

class DataResource < ApplicationRecord
  belongs_to :resourceable, polymorphic: true
  belongs_to :publisher, class_name: 'Organisation'
  belongs_to :source, optional: true
  has_many :creations, dependent: :destroy
  has_many :creators, through: :creations, class_name: 'Organisation', source: :organisation
  has_many :related_resources, dependent: :destroy
  has_many :related_data_resources, through: :related_resources, class_name: 'DataResource'

  enum :access_rights, { INTERNAL: 0, OPEN: 1, COMMERCIAL: 2 }
  enum :security_classification, { OFFICIAL: 0, SECRET: 1, TOP_SECRET: 2 }

  include PgSearch::Model
  pg_search_scope :search,
                  against: { title: 'A', description: 'B', summary: 'C' },
                  associated_against: { publisher: { name: 'D' } },
                  using: { tsearch: { prefix: true, dictionary: 'english' } }

  def summary
    read_attribute(:summary).presence || description&.truncate(250)
  end
end
