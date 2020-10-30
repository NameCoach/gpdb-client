# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::RecordingRequest::Resource do
  let(:gpdb_url) { Gpdb.configuration.api_url }

  let(:instance) { ::Gpdb::REST::Client.new.recording_requests }

  describe '#create' do
    let(:target)          { 'alex' }
    let(:target_type_sig) { 'person_first_name' }
    let(:owner_context)   { {} }
    let(:app_context)     { { app_type_sig: 'app_sig' } }
    let(:user_context)    { { signature: 'user_sig' } }
    let(:params) do
      {
        target:               target,
        target_type_sig:      target_type_sig,
        target_owner_context: owner_context,
        application_context:  app_context,
        user_context:         user_context
      }
    end

    before do
      stub_request(:post, Regexp.new("#{gpdb_url}/api/public/v1/recording_requests"))
        .to_return(status: gpdb_status, body: gpdb_response.to_json)
    end

    subject { instance.create(params) }

    context '201' do
      let(:gpdb_status)   { 201 }
      let(:gpdb_response) { { recording_request_id: 1, target: target } }

      it 'performs a request and returns a wrapped response' do
        expect(subject).to be_a Gpdb::REST::RecordingRequest::Response

        expect(subject.status).to eq 201
        expect(subject.body).to eq gpdb_response
      end
    end

    context '422' do
      let(:gpdb_status)   { 422 }
      let(:gpdb_response) { { errors: { name: "can't be blank" } } }

      it 'contains errors' do
        expect(subject.status).to eq 422
        expect(subject.body).to eq gpdb_response
        expect(subject.errors).to eq gpdb_response[:errors]
      end
    end
  end
end
