# frozen_string_literal: true

FactoryBot.define do
  factory :source do
    name { 'HMRC apis descriptions' }
    url { Faker::Internet.unique.url }
  end
end
