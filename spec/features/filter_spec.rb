# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Filters' do
  before do
    create_list(:data_service, 5)
    @organisation_test = create(:organisation, name: 'Test Organisation')
    @data_service_test = create(:data_service, name: 'Test API', organisation: @organisation_test)
    page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
  end

  it 'User loads the page with all services' do
    visit '/'
    expect(page).to have_selector('div.govuk-checkboxes--small div', count: 6)
  end

  it 'Shows only data from selected organisation' do
    visit '/'
    # select filters
    check("filters_#{@organisation_test.id}")
    click_button 'Apply filters'
    expect(page).to have_selector('ul.data-services li', count: 1)

    # clear filters
    click_link('Clear filters')
    expect(page).to have_selector('ul.data-services li', count: 6)
  end
end
