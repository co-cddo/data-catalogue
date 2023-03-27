# frozen_string_literal: true

FactoryBot.define do
  factory :data_resource do
    source

    resourceable { create(:data_service) }
    publisher { create(:organisation) }
  end
end
