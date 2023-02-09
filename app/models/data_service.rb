# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :source

  validates :name, :url, presence: true

  delegate :organisation, to: :source
end
