# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pagination' do
  context 'when using the pagination nav' do
    let(:organisation_test) { create(:organisation, name: 'Test Organisation') }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      create_list(:data_service, 21)
      create(:data_service, name: 'Test Data Service', organisation_id: organisation_test.id)
      visit '/data_services'
    end

    it 'displays the pagination nav' do
      expect(page).to have_selector('nav.govuk-pagination')
    end

    it 'displays the pagination buttons' do
      expect(page).to have_selector('ul.govuk-pagination__list', count: 1)
    end

    it 'displays the pagination 3 buttons, page 1, 2 and next' do
      expect(page).to have_selector('a.govuk-link.govuk-pagination__link', count: 3)
    end

    it 'displays the next pagination navigation button' do
      expect(page).to have_selector('div.govuk-pagination__next', count: 1)
    end

    it 'does not display the previous pagination button' do
      expect(page).not_to have_selector('div.govuk-pagination__prev')
    end
  end
end

RSpec.describe 'No Pagination' do
  context 'when results are under 20 there should be no pagination' do
    let(:organisation_test) { create(:organisation, name: 'Test Organisation') }

    before do
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      create_list(:data_service, 8)
      create(:data_service, name: 'Test Data Service', organisation_id: organisation_test.id)
      visit '/data_services'
    end

    it 'does not display the pagination nav' do
      expect(page).not_to have_selector('nav.govuk-pagination')
    end

    it 'does not display the pagination buttons' do
      expect(page).not_to have_selector('ul.govuk-pagination__list')
    end

    it 'does not display pagination navigation buttons' do
      expect(page).not_to have_selector('a.govuk-link.govuk-pagination__link')
    end

    it 'does not display the next pagination button' do
      expect(page).not_to have_selector('div.govuk-pagination__next')
    end

    it 'does not display the previous pagination button' do
      expect(page).not_to have_selector('div.govuk-pagination__prev')
    end
  end
end
