# frozen_string_literal: true

class DataService < ApplicationRecord
  belongs_to :organisation
  belongs_to :source, optional: true

  validates :name, :url, presence: true
end
