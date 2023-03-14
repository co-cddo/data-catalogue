# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataService do
  describe 'associations' do
    it { is_expected.to belong_to(:organisation).optional }
    it { is_expected.to belong_to(:source).optional }
  end

  describe 'validations' do
    # it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_presence_of(:url) }
  end

  describe 'search' do
    let(:name) { Faker::Company.bs }
    let(:description) { Faker::Company.bs }
    let(:organisation) { create(:organisation) }

    before do
      create_list(:data_service, 10)
    end

    context 'when searched by name' do
      it 'returns the right results' do
        service = create(:data_service, name:)
        results = described_class.search(name)
        expect(results.first).to eq(service)
      end
    end

    context 'when searched by description' do
      it 'returns the right results' do
        service = create(:data_service, description:)
        results = described_class.search(description)
        expect(results.first).to eq(service)
      end
    end

    context 'when searched by organisation' do
      it 'returns the right results' do
        service = create(:data_service, organisation:)
        results = described_class.search(organisation.name)
        expect(results.first).to eq(service)
      end
    end

    context 'when ranking' do
      let(:text) { Faker::Company.bs }

      it 'orders results correctly by name' do
        create(:data_service, description: text)
        create(:data_service, organisation: create(:organisation, name: text))
        service_name = create(:data_service, name: text)
        results = described_class.search(text)
        expect(results.first).to eq(service_name)
      end

      it 'orders results correctly by description' do
        create(:data_service, name: text)
        create(:data_service, organisation: create(:organisation, name: text))
        service_description = create(:data_service, description: text)
        results = described_class.search(text)
        expect(results.second).to eq(service_description)
      end

      it 'orders results correctly by organisation' do
        create(:data_service, name: text)
        create(:data_service, description: text)
        service_organisation = create(:data_service, organisation: create(:organisation, name: text))
        results = described_class.search(text)
        expect(results.third).to eq(service_organisation)
      end
    end
  end
end
