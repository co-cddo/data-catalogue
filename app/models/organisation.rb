# frozen_string_literal: true

class Organisation < ApplicationRecord
  SLUGS = {
    'Department for Work and Pensions' => 'department-for-work-pensions',
    'Food Standards Agency' => 'food-standards-agency',
    'NHS Digital' => 'nhs-digital'
  }.freeze

  has_many :published_resources, class_name: 'DataResource', dependent: :nullify
  has_many :creations, dependent: :nullify
  has_many :data_resources, through: :creations

  validates :slug, presence: true
  validates :slug, uniqueness: true

  scope :id_name_slug_order_asc, -> { select(%i[id name slug]).order('name ASC') }

  before_validation :set_slug

  protected

  def set_slug
    return if slug

    self.slug = SLUGS[name]
  end
end
