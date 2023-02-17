# frozen_string_literal: true

class Source < ApplicationRecord
  has_many :data_services, dependent: :nullify

  validates :name, :url, presence: true
  validates :url, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  enum :kind, { http: 0 }
end
