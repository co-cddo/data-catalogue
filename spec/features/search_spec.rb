require 'rails_helper'

RSpec.feature "Searches", type: :feature do
  before do
    5.times { create :data_service }
    create :data_service, name: 'Test API'
  end

  scenario "User loads the page with all services" do
    page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
    visit "/"
    expect(page).to have_selector('ul.data-services li', count: 6)
  end
  
  scenario "User searches for a service" do
    page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
    visit "/"
    fill_in 'query', with: 'Test'
    click_button 'Search'
    expect(page).to have_content 'Test'
    expect(page).not_to have_content 'VAT'
  end
end
