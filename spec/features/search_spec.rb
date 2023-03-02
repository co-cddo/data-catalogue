# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches' do
  context 'when page is loaded' do
    before do
      create_list(:data_service, 6)
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
    end

    it 'displays all services' do
      visit '/data_services'
      expect(page).to have_selector('ul.data-services li', count: 6)
    end
  end

  context 'when search is performed' do
    before do
      create_list(:data_service, 5)
      create(:data_service, name: 'Test API')
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
    end

    context 'from the data services page' do
      before do
        visit '/data_services'
      end

      it 'finds relevant results' do
        fill_in 'query', with: 'Test'
        click_button 'Search'
        expect(page).to have_content 'Test'
      end
    end

    context 'from the homepage' do
      before do
        visit '/'
      end

      it 'finds relevant results' do
        fill_in 'query', with: 'Test'
        click_button 'Search'
        expect(page).to have_content 'Test'
      end
    end
  end
end
