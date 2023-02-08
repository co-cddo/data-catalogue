# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches' do
  before do
    create_list(:data_service, 5)
    create(:data_service, name: 'Test API')
    page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
  end

  it 'User loads the page with all services' do
    visit '/'
    expect(page).to have_selector('ul.data-services li', count: 6)
  end

  it 'User searches for a service' do
    visit '/'
    fill_in 'query', with: 'Test'
    click_button 'Search'
    expect(page).to have_content 'Test'
    expect(page).not_to have_content 'VAT'
  end
end
