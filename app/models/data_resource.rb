# frozen_string_literal: true

class DataResource < ApplicationRecord
  belongs_to :resourceable, polymorphic: true

  enum :access_rights, { internal: 0, open: 1, commercial: 2 }
  enum :security_classification, { official: 0, official_sensitive: 1, secret: 2, top_secret: 3 }
end
