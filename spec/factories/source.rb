# frozen_string_literal: true

FactoryBot.define do
  factory :source do
    organisation

    name { 'HMRC apis descriptions' }
    url { 'https://www.gov.uk/government/organisations/hm-revenue-customs/api_description' }
  end
end
