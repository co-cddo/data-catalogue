# frozen_string_literal: true

# spec/features/data_resource_spec.rb

require 'rails_helper'

RSpec.describe 'data_resources/data_resource.html.erb' do
  context 'when viewing the summary of the resource' do
    let(:summary_text) { Faker::Company.bs }
    let!(:data_resource_one) { create(:data_resource, title: 'Test One', summary: summary_text) }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      visit '/data_resources'
    end

    it 'displays the summary element when summary is present' do
      expect(page).to have_css('p', text: data_resource_one.summary)
    end
  end

  context 'when viewing the description of the resource' do
    let(:description_text) { Faker::Lorem.paragraph }
    let!(:data_resource_two) { create(:data_resource, title: 'Test Two', description: description_text) }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      visit '/data_resources'
    end

    it 'displays the description element when summary is absent' do
      expect(page).to have_css('p', text: data_resource_two.description.truncate(250))
    end
  end
end
