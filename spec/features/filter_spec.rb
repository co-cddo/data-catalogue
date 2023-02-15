# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Filters' do
  context 'when filtering by organisations' do
    let(:organisation_test) { create(:organisation, name: 'Test Organisation') }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      create_list(:data_service, 5)
      create(:data_service, name: 'Test Data Service', organisation_id: organisation_test.id)
    end

    it 'User loads the page with all services' do
      visit '/'
      expect(page).to have_selector('div.govuk-checkboxes--small div', count: 6)
    end

    it 'Shows only data from selected organisation' do
      visit '/'
      check("filters_#{organisation_test.id}")
      click_button 'Apply filters'
      expect(page).to have_selector('ul.data-services li', count: 1)
    end

    it 'Clears filters' do
      visit '/'
      check("filters_#{organisation_test.id}")
      click_button 'Apply filters'
      click_link('Clear filters')
      expect(page).to have_selector('ul.data-services li', count: 6)
    end
  end
end
