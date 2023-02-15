# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataServices::Creator do
  describe '#call' do
    subject(:creator) { described_class.call(name:, url:, organisation_name:, optional:) }

    context 'when without name' do
      let(:name) { nil }
      let(:url) { Faker::Internet.unique.url }
      let(:organisation) { create(:organisation) }
      let(:organisation_name) { organisation.name }
      let(:optional) { {} }

      it 'does not create a DataService' do
        expect(creator).not_to be_valid
      end
    end

    context 'when without url' do
      let(:name) { Faker::Company.bs }
      let(:url) { nil }
      let(:organisation) { create(:organisation) }
      let(:organisation_name) { organisation.name }
      let(:optional) { {} }

      it 'does not create a DataService' do
        expect(creator).not_to be_valid
      end
    end

    context 'when without organisation_name' do
      let(:name) { Faker::Company.bs }
      let(:url) { Faker::Internet.unique.url }
      let(:organisation_name) { nil }
      let(:optional) { {} }

      it 'does not create a DataService' do
        expect(creator).not_to be_valid
      end
    end

    context 'when with valid arguments' do
      let(:name) { Faker::Company.bs }
      let(:url) { Faker::Internet.unique.url }
      let(:organisation) { create(:organisation) }
      let(:organisation_name) { organisation.name }
      let(:optional) { {} }

      it 'does create a DataService' do
        expect(creator).to be_valid
      end

      [:contact, :description, :documentation_url, :source].each do |argument|
        it "has not #{argument}" do
          expect(creator.send(argument)).to be_nil
        end
      end

      context 'when with a contact' do
        let(:optional) { { contact: Faker::Internet.email } }

        it 'does create a DataService' do
          expect(creator).to be_valid
        end

        it 'has a contact' do
          expect(creator.contact).to eq(optional[:contact])
        end
      end

      context 'when with a description' do
        let(:optional) { { description: Faker::Lorem.paragraph } }

        it 'does create a DataService' do
          expect(creator).to be_valid
        end

        it 'has a description' do
          expect(creator.description).to eq(optional[:description])
        end
      end

      context 'when with a documentation_url' do
        let(:optional) { { documentation_url: Faker::Internet.url } }

        it 'does create a DataService' do
          expect(creator).to be_valid
        end

        it 'has a documentation_url' do
          expect(creator.documentation_url).to eq(optional[:documentation_url])
        end
      end

      context 'when with a source' do
        let(:source) { create :source }
        let(:optional) { { source_id: source.id } }

        it 'does create a DataService' do
          expect(creator).to be_valid
        end

        it 'has a source' do
          expect(creator.source).to eq(source)
        end
      end

      context 'when with existing organisation' do
        let(:second_data_service) { described_class.call(name:, url:, organisation_name:, optional:) }

        it 'does create a DataService' do
          expect(second_data_service).to be_valid
        end

        it 'does not duplicate organisation' do
          expect(second_data_service.organisation).to eq(creator.organisation)
        end
      end
    end
  end
end
