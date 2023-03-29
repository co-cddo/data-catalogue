# frozen_string_literal: true

class Organisation < ApplicationRecord
  NAMES = {
    'department-for-work-pensions' => 'Department for Work and Pensions',
    'food-standards-agency' => 'Food Standards Agency',
    'nhs-digital' => 'NHS Digital'
  }.freeze

  has_many :published_resources, class_name: 'DataResource', dependent: :nullify, foreign_key: :publisher_id,
                                 inverse_of: :publisher
  has_many :creations, dependent: :nullify
  has_many :data_resources, through: :creations

  validates :slug, presence: true
  validates :slug, uniqueness: true

  scope :id_name_order_asc, -> { select(%i[id name]).order('name ASC') }

  before_validation :set_name

  protected

  def set_name
    return if name

    self.name ||= NAMES[slug] || slug.titleize
  end
end
