# frozen_string_literal: true

class Dataset < ApplicationRecord
  has_one :data_resource, as: :resourceable, dependent: :destroy
end
