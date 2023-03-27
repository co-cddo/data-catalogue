# frozen_string_literal: true

FactoryBot.define do
  factory :data_service do
    organisation

    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    url { Faker::Internet.url }
  end
end
