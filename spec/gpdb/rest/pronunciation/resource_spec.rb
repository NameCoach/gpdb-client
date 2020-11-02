# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::Pronunciation::Resource do
  let(:gpdb_url) { Gpdb.configuration.api_url }

  let(:instance) { ::Gpdb::REST::Client.new.pronunciations }

  describe '#simple_search' do
    let(:target)   { 'alex' }
    let(:app_sig)  { 'app_sig' }
    let(:app_type) { 'app_type' }
    let(:options)  { {} }
    let(:params)   { { target: target, app_sig: app_sig, app_type: app_type, **options } }

    before do
      stub_request(:get, Regexp.new("#{gpdb_url}/api/public/v1/pronunciations"))
        .with(query: hash_including(
          target:               target,
          application_sig:      app_sig,
          application_type_sig: app_type
        ))
        .to_return(status: gpdb_status, body: gpdb_response.to_json)
    end

    subject { instance.simple_search(params) }

    context '200' do
      let(:gpdb_status)          { 200 }
      let(:gpdb_pronunciations)  { [{ id: 'pronunciation_1' }, { id: 'pronunciation_2' }] }
      let(:gpdb_meta)            { { version: '0.1:not_available' } }
      let(:gpdb_response) do
        {
          target_result: {
            pronunciations: gpdb_pronunciations,
            target_origin:  target
          },
          meta: gpdb_meta
        }
      end

      it 'performs a request and returns a wrapped response' do
        expect(subject.status).to eq 200
        expect(subject.body).to be_present

        expect(subject.meta).to eq gpdb_meta
        expect(subject.target).to be_a Gpdb::REST::Target::Model

        expect(subject.target.origin).to eq target
      end

      context 'when options are provided' do
        let(:options) { { user_sig: 'user_sig' } }

        it 'send given options as additional parameters' do
          expect(::Gpdb::REST::Request).to receive(:new).with(
            hash_including(params: hash_including(options))
          ).and_call_original

          subject
        end
      end
    end

    context '400' do
      let(:gpdb_status)   { 400 }
      let(:gpdb_response) { { message: 'error message' } }

      it 'contains an error message' do
        expect(subject.status).to eq 400
        expect(subject.body).to eq gpdb_response

        expect(subject.meta).to eq nil
        expect(subject.target).to eq nil
      end
    end
  end

  describe '#complex_search' do
    let(:targets)      { %w[alex jack] }
    let(:app_context)  { { app_type_sig: 'app_sig' } }
    let(:user_context) { { signature: 'user_sig' } }

    let(:params) { { targets: targets, application_context: app_context, user_context: user_context } }

    before do
      stub_request(:post, Regexp.new("#{gpdb_url}/api/public/v1/pronunciations/search"))
        .to_return(status: gpdb_status, body: gpdb_response.to_json)
    end

    subject { instance.complex_search(params) }

    context '200' do
      let(:gpdb_pronunciations_1) { [{ id: 'alex_1' }, { id: 'alex_2' }] }
      let(:gpdb_pronunciations_2) { [{ id: 'jack' }] }
      let(:gpdb_status)           { 200 }
      let(:gpdb_meta)             { { version: '0.1:not_available' } }
      let(:gpdb_response) do
        {
          target_results: [
            { pronunciations: gpdb_pronunciations_1, target_origin: 'alex' },
            { pronunciations: gpdb_pronunciations_2, target_origin: 'jack' }
          ],
          meta: gpdb_meta
        }
      end

      it 'performs a request and returns a wrapped response' do
        expect(subject.status).to eq 200
        expect(subject.body).to be_present

        expect(subject.meta).to eq gpdb_meta
        expect(subject.target_results).to be_an Array
        expect(subject.target_results).to all(be_a Gpdb::REST::Target::Model)

        expect(subject.target_results.length).to eq gpdb_response[:target_results].length
      end
    end

    context '400' do
      let(:gpdb_status)   { 400 }
      let(:gpdb_response) { { message: 'error message' } }

      it 'contains an error message' do
        expect(subject.status).to eq 400
        expect(subject.body).to eq gpdb_response

        expect(subject.meta).to eq nil
        expect(subject.target_results).to eq nil
      end
    end
  end

  describe '#create' do
    let(:name)         { 'alex' }
    let(:base64)       { 'base64_string' }
    let(:app_context)  { { app_type_sig: 'app_sig' } }
    let(:user_context) { { signature: 'user_sig' } }
    let(:options)      { {} }
    let(:params) do
      { name: name, base64_audio: base64, application_context: app_context, user_context: user_context, **options }
    end

    before do
      stub_request(:post, Regexp.new("#{gpdb_url}/api/public/v1/pronunciations"))
        .to_return(status: gpdb_status, body: gpdb_response.to_json)
    end

    subject { instance.create(params) }

    context '200' do
      let(:gpdb_status)   { 200 }
      let(:gpdb_response) { { id: 1, audio_url: 'an_audio_url' } }

      it 'performs a request and returns a wrapped response' do
        expect(subject).to be_a Gpdb::REST::Response

        expect(subject.status).to eq 200
        expect(subject.body).to eq gpdb_response
      end

      context 'when options are provided' do
        let(:options) { { target_type_sig: 'type_sig' } }

        it 'send given options as additional parameters' do
          expect(::Gpdb::REST::Request).to receive(:new).with(
            hash_including(params: hash_including(options))
          ).and_call_original

          subject
        end
      end
    end

    context '400' do
      let(:gpdb_status)   { 400 }
      let(:gpdb_response) { { message: 'error message' } }

      it 'contains an error message' do
        expect(subject.status).to eq 400
        expect(subject.body).to eq gpdb_response
      end
    end

    context '422' do
      let(:gpdb_status)   { 422 }
      let(:gpdb_response) { { errors: 'error message' } }

      it 'contains errors' do
        expect(subject.status).to eq 422
        expect(subject.body).to eq gpdb_response
        expect(subject.errors).to eq gpdb_response[:errors]
      end
    end
  end
end
