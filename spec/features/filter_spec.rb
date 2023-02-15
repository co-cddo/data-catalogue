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

    it 'User loads the page with all services but the clear filters button is not visible' do
      visit '/'
      expect(page).to have_selector('div.govuk-checkboxes--small div', count: 6)
      expect(page).to_not have_selector('a.govuk-link.govuk-link--no-visited-state[data-cy="data-service-clear-filters-button"]')
    end

    it 'User loads page, filters by organisation, the results are displayed and clear filters button becomes visible' do
      visit '/'
      check("filters_#{organisation_test.id}")
      click_button 'Apply filters'
      expect(page).to have_selector('ul.data-services li', count: 1)
      expect(page).to have_selector('a.govuk-link.govuk-link--no-visited-state[data-cy="data-service-clear-filters-button"]', count: 1)
    end

    it 'User loads page, filters by organisation and then removes the filters which then displays all services' do
      visit '/'
      check("filters_#{organisation_test.id}")
      click_button 'Apply filters'
      click_link('Clear filters')
      expect(page).to have_selector('ul.data-services li', count: 6)
    end
  end
end
