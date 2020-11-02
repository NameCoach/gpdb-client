# frozen_string_literal: true

module Gpdb
  module REST
    class Client
      attr_accessor :http_client
      attr_accessor :recording_requests, :pronunciations

      def initialize
        self.http_client = HttpClient.new

        self.recording_requests = Gpdb::REST::RecordingRequest::Resource.new(self)
        self.pronunciations = Gpdb::REST::Pronunciation::Resource.new(self)
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
