# frozen_string_literal: true

class Dataset < ApplicationRecord
  has_one :resource, as: :resourceable, dependent: :destroy
end
