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
      expect(page).to have_content 'Next'
    end

    it 'displays the pagination 3 buttons on page 2, page 1, 2 and previous' do
        click_link '2'
        expect(page).to have_selector('a.govuk-link.govuk-pagination__link', count: 3)
        expect(page).to have_content 'Previous'
      end

    it 'displays the next pagination navigation button' do
      expect(page).to have_selector('div.govuk-pagination__next', count: 1)
    end

    it 'does not display the previous pagination button' do
      expect(page).not_to have_selector('div.govuk-pagination__prev')
    end

    it 'shows correct results at the top of the page' do
        expect(page).to have_content '22 results'
    end 
    
    it 'shows correct results at the bottom of the page' do
        expect(page).to have_content '1 to 20 of 22 results'
    end 

    it 'clicks next link' do
        click_link 'Next'
        expect(page).to have_content 'Showing 21 to 22'
        click_link 'Previous'
        expect(page).to have_content 'Showing 1 to 20'
      end
    
      it 'navigates using number links' do
        click_link '2'
        expect(page).to have_content 'Showing 21 to 22'
        click_link '1'
        expect(page).to have_content 'Showing 1 to 20'
      end
    
  end

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

    it 'does not display the pagination links' do
      expect(page).not_to have_selector('ul.govuk-pagination__list')
    end

    it 'does not display pagination navigation links' do
      expect(page).not_to have_selector('a.govuk-link.govuk-pagination__link')
    end

    it 'does not display the next pagination link' do
      expect(page).not_to have_selector('div.govuk-pagination__next')
    end

    it 'does not display the previous pagination link' do
      expect(page).not_to have_selector('div.govuk-pagination__prev')
    end

    it 'does not display numbered pagination links' do
        expect(page).not_to have_selector('div.govuk-pagination__link')
      end
  end
end
