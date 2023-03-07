# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :data_services, dependent: :destroy

  validates :name, presence: true

  scope :id_name_order_ASC, -> { select(%i[id name]).order('name ASC') }
end
