# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Filters' do
  context 'when using the filter' do
    let(:organisation_test) { create(:organisation, name: 'Test Organisation') }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      create_list(:data_service, 5)
      create(:data_service, name: 'Test Data Service', organisation_id: organisation_test.id)
      visit '/data_services'
    end

    context 'when loading the initial page' do
      it 'displays all services' do
        expect(page).to have_selector('div.govuk-checkboxes--small div', count: 6)
      end

      it 'conceals the clear filters button' do
        expect(page).not_to have_selector('a.govuk-link.govuk-link--no-visited-state')
      end
    end

    context 'when filtering by an organisation' do
      before do
        check("filters_#{organisation_test.id}")
        click_button 'Apply filters'
      end

      it 'displays the filtered results and the clear filters button' do
        expect(page).to have_selector('ul.data-services li', count: 1)
      end

      it 'displays the clear filters button' do
        expect(page).to have_selector('a.govuk-link.govuk-link--no-visited-state')
      end

      context 'when clicking the clear filters button' do
        before do
          click_link('Clear filters')
        end

        it 'removes the filters and displays all services' do
          expect(page).to have_selector('ul.data-services li', count: 6)
        end
      end
    end
  end
end
