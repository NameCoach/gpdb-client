# frozen_string_literal: true

module Gpdb
  module REST
    class Client
      attr_accessor :http_client
      attr_accessor :recordings, :external_uris, :recording_requests, :apps,
                    :recording_verifications, :recording_verification_uri_refs,
                    :pronunciations, :phonetics

      def initialize
        self.http_client = HttpClient.new

        self.recordings = Gpdb::REST::Recording::Resource.new(self)
        self.external_uris = Gpdb::REST::ExternalUri::Resource.new(self)
        self.recording_requests = Gpdb::REST::RecordingRequest::Resource.new(self)
        self.apps = Gpdb::REST::App::Resource.new(self)
        self.recording_verifications = Gpdb::REST::RecordingVerification::Resource.new(self)
        self.recording_verification_uri_refs = Gpdb::REST::RecordingVerificationUriRef::Resource.new(self)
        self.pronunciations = Gpdb::REST::Pronunciation::Resource.new(self)
        self.phonetics = Gpdb::REST::Phonetic::Resource.new(self)
      end

      def request(request, namespace: Gpdb.configuration.namespace)
        request.api_url = Gpdb.configuration.api_url
        request.path    = "#{namespace}#{request.path}"
        request.headers = { 'Authorization': Gpdb.configuration.credentials.signature_header }

        response = http_client.request(request)

        Response.new(body: response.body, status: response.status, _response: response)
      end
    end
  end
end
