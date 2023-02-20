# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches' do
  context 'when performing a search' do
    before do
      create_list(:data_service, 5)
      create(:data_service, name: 'Test API')
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
      visit '/'
    end

    context 'when loading the initial page' do
      it 'loads the page and displays all services' do
        expect(page).to have_selector('ul.data-services li', count: 6)
      end
    end

    context 'when searching for a service name' do
      before do
        fill_in 'query', with: 'Test'
        click_button 'Search'
      end

      it 'displays relevant search results' do
        expect(page).to have_content 'Test'
        expect(page).not_to have_content 'VAT'
      end
    end
  end
end
