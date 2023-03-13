# frozen_string_literal: true

FactoryBot.define do
  factory :organisation do
    name { Faker::Company.name }
    slug { Faker::Internet.unique.slug }
  end
end
