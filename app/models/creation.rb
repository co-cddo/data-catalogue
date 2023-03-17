# frozen_string_literal: true

class Creation < ApplicationRecord
  belongs_to :data_resource
  belongs_to :organisation
end
