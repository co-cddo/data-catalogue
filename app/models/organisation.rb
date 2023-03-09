# frozen_string_literal: true

class Organisation < ApplicationRecord
  SLUGS = {
    'Department for Work and Pensions' => 'department-for-work-pensions',
    'Food Standards Agency' => 'food-standards-agency',
    'NHS Digital' => 'nhs-digital'
  }.freeze

  has_many :data_services, dependent: :destroy

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  scope :id_name_order_ASC, -> { select(%i[id name]).order('name ASC') }

  before_validation :set_slug

  protected

  def set_slug
    return if slug

    self.slug = SLUGS[name]
  end
end
