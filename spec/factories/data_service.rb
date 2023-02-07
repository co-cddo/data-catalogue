# frozen_string_literal: true

FactoryBot.define do
  factory :data_service do
    organisation
    
    name { 'HMRC api' }
    description { 'Description' }
    url { 'https://gov.uk/service.json' }
  end
end