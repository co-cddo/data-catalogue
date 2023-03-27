# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches' do
  context 'when page is loaded' do
    before do
      create_list(:data_resource, 6)
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
    end

    it 'displays all services' do
      visit '/data_resources'
      expect(page).to have_selector('ul.data-services li', count: 6)
    end
  end

  context 'when search is performed' do
    before do
      create_list(:data_resource, 5)
      create(:data_resource, title: 'Test API')
      page.driver.browser.authorize ENV.fetch('HTTP_USERNAME'), ENV.fetch('HTTP_PASSWORD')
    end

    context 'when on the data services page' do
      before do
        visit '/data_resources'
      end

      it 'finds relevant results' do
        fill_in 'query', with: 'Test'
        click_button 'Search'
        expect(page).to have_content 'Test'
      end
    end

    context 'when on the homepage' do
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
