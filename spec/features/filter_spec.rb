# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Filters' do
  context 'when using the filter' do
    let(:organisation_test) { create(:organisation, name: 'Test Organisation') }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      create_list(:data_resource, 5)
      create(:data_resource, title: 'Test Data Resource', publisher_id: organisation_test.id)
      visit '/data_resources'
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

    context 'when collapsing the filters' do
      before do
        click_button 'Organisations'
      end

      it 'hides all checkboxes from view' do
        expect(page).not_to have_selector('govuk-checkboxes__item')
      end
    end

    context 'when the filter is expanded by default' do
      it 'displays all checkboxes' do
        expect(page).to have_selector('div.govuk-checkboxes--small div', count: 6)
      end
    end

    context 'when on the homepage' do
      before do
        visit '/'
      end

      it 'filters by organisation' do
        find('a[data-cy="Test Organisation-filter-link"]').click
        expect(page).to have_selector('ul.data-services li', count: 1)
      end
    end
  end
end
