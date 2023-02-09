class Source < ApplicationRecord
  belongs_to :organisation
  has_many :data_services

  validates :name, :url, presence: true
  validates :url, uniqueness: true
end
