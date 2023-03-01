# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonValidator do
  let(:json) { '{"data":"data"}' }

  describe '#call' do
    before do
      allow(Open3).to receive(:capture2)
    end

    context 'when successful' do
      it 'receives the right command' do
        described_class.call(json:, schema_path: '/test/schema.json')
        expect(Open3).to have_received(:capture2).with(
          %r{check-jsonschema -v --schemafile /test/schema.json}
        )
      end
    end
  end
end
