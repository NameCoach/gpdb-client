# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::RecordingRequest::Response do
  describe '#initialize' do
    subject { described_class.new(response) }

    context 'when a response is successful' do
      let(:response) do
        {
          status:    200,
          body:      { recording_request_id: 'id' },
          _response: double(success?: true)
        }
      end

      it 'wraps recording_request in the model' do
        expect(subject.status).to eq response[:status]
        expect(subject.body).to eq response[:body]

        expect(subject.recording_request).to be_a Gpdb::REST::RecordingRequest::Model
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

        expect(subject.recording_request).to eq nil
      end
    end
  end
end
