require 'rails_helper'

RSpec.describe SearchService do
  subject(:search) { SearchService.call(q: q) }

  describe '#call' do
    context 'when query is empty' do
      let(:q) { '' }

      it 'returns empty' do
        expect(subject).to be_empty
      end
    end

    context 'when query is present' do
      context 'and on the service name' do
        let(:q) { 'relevant service' }

        before do
          5.times do
            create :data_service
          end
          create :data_service, name: 'Relevant Service 1'
          create :data_service, name: 'Relevant Service 2'
        end

        it 'returns the correct number of results' do
          expect(subject.count).to eq(2)
        end

        it 'returns the correct results' do
          expect(subject.collect(&:name)).to all(match /#{q}/i)
        end
      end
    end

    context 'and on the service description' do
      let(:q) { 'relevant service' }

      before do
        5.times do
          create :data_service
        end
        create :data_service, description: 'Relevant Service 1'
        create :data_service, description: 'Relevant Service 2'
      end

      it 'returns the correct number of results' do
        expect(subject.count).to eq(2)
      end

      it 'returns the correct results' do
        expect(subject.collect(&:description)).to all(match /#{q}/i)
      end
    end

    context 'and on the organisation name' do
      let(:q) { 'relevant organisation' }

      before do
        5.times do
          create :data_service
        end
        organisation = create :organisation, name: 'Relevant Organisation'
        create :data_service, organisation: organisation
        create :data_service, organisation: organisation
      end

      it 'returns the correct number of results' do
        expect(subject.count).to eq(2)
      end

      it 'returns the correct results' do
        expect(subject.collect { |ds| ds.organisation.name }).to all(match /#{q}/i)
      end
    end
  end
end