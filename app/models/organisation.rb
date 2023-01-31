# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :data_services, dependent: true
end
