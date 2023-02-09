# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :sources, dependent: :destroy
  has_many :data_services, through: :sources

  validates :name, presence: true
end
