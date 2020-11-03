# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::Pronunciation::TargetListResponse do
  describe '#initialize' do
    subject { described_class.new(response) }

    context 'when a response is successful' do
      let(:target_results) { [{ target_id: 1, target_origin: 'alex' }, { target_id: 2, target_origin: 'jack' }] }
      let(:meta) { { version: 'version' } }
      let(:response) do
        {
          status:    200,
          body:      { target_results: target_results, meta: meta },
          _response: double(success?: true)
        }
      end

      it 'contains the target models and the meta' do
        expect(subject.status).to eq response[:status]
        expect(subject.body).to eq response[:body]

        expect(subject.target_results).to be_an Array
        expect(subject.target_results).to all(be_a Gpdb::REST::Pronunciation::Target)
        expect(subject.meta).to eq meta
      end
    end

    context 'when a response is not successful' do
      let(:response) do
        {
          status:    422,
          body:      { errors: 'some error' },
          _response: double(success?: false)
        }
      end

      it 'does not contains recording_request' do
        expect(subject.status).to eq response[:status]
        expect(subject.body).to eq response[:body]

        expect(subject.target_results).to eq nil
        expect(subject.meta).to eq nil
      end
    end
  end
end


