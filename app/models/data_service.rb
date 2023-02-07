# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :organisation

  validates :name, :url, presence: true
end
