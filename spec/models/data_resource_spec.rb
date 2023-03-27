# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataResource do
  subject(:data_resource) { build(:data_resource) }

  let(:organisations) { create_list(:organisation, 2) }
  let(:related_data_resources) { create_list(:data_resource, 2) }

  describe 'associations' do
    it { is_expected.to belong_to(:resourceable) }
    it { is_expected.to belong_to(:publisher) }
    it { is_expected.to have_many(:creations) }
    it { is_expected.to have_many(:creators) }
    it { is_expected.to have_many(:related_resources) }
    it { is_expected.to have_many(:related_data_resources) }
  end

  context 'when registering creators' do
    it 'registers organisations' do
      data_resource.creators = organisations
      expect(data_resource.creators).to eq(organisations)
    end
  end

  context 'when registering related data resources' do
    it 'registers data resources' do
      data_resource.related_data_resources = related_data_resources
      expect(data_resource.related_data_resources).to eq(related_data_resources)
    end
  end

  describe 'search' do
    let(:title) { Faker::Company.bs }
    let(:description) { Faker::Company.bs }
    let(:organisation) { create(:organisation) }

    before do
      create_list(:data_resource, 10)
    end

    context 'when searched by title' do
      it 'returns the right results' do
        resource = create(:data_resource, title:)
        results = described_class.search(title)
        expect(results.first).to eq(resource)
      end
    end

    context 'when searched by description' do
      it 'returns the right results' do
        resource = create(:data_resource, description:)
        results = described_class.search(description)
        expect(results.first).to eq(resource)
      end
    end

    context 'when searched by summary' do
      it 'returns the right results' do
        resource = create(:data_resource, summary: description)
        results = described_class.search(description)
        expect(results.first).to eq(resource)
      end
    end

    context 'when searched by publisher' do
      it 'returns the right results' do
        resource = create(:data_resource, publisher: organisation)
        results = described_class.search(organisation.name)
        expect(results.first).to eq(resource)
      end
    end

    context 'when ranking' do
      let(:text) { Faker::Company.bs }

      it 'orders results correctly by title' do
        create(:data_resource, description: text)
        create(:data_resource, summary: text)
        create(:data_resource, publisher: create(:organisation, name: text))
        resource = create(:data_resource, title: text)
        expect(described_class.search(text).first).to eq(resource)
      end

      it 'orders results correctly by description' do
        create(:data_resource, title: text)
        create(:data_resource, summary: text)
        create(:data_resource, publisher: create(:organisation, name: text))
        resource = create(:data_resource, description: text)
        expect(described_class.search(text).second).to eq(resource)
      end

      it 'orders results correctly by summary' do
        create(:data_resource, title: text)
        create(:data_resource, description: text)
        create(:data_resource, publisher: create(:organisation, name: text))
        resource = create(:data_resource, summary: text)
        expect(described_class.search(text).third).to eq(resource)
      end

      it 'orders results correctly by publisher' do
        create(:data_resource, title: text)
        create(:data_resource, description: text)
        create(:data_resource, summary: text)
        resource = create(:data_resource, publisher: create(:organisation, name: text))
        expect(described_class.search(text).fourth).to eq(resource)
      end
    end
  end
end
