# frozen_string_literal: true

module Gpdb
  module REST
    module RecordingRequest
      class Resource < Gpdb::REST::BaseResource
        # @param [Hash] params - recording request Attributes
        # @return [Gpdb::REST::Response]
        def create(params)
          attributes = {}
          params = params.symbolize_keys

          attributes[:name] = params.fetch(:name)
          attributes[:user_id] = params.fetch(:user_id)

          request = ::Gpdb::REST::Request.new(
            method: :post,
            path:   '/recording_requests',
            params: {
              recording_request: attributes
            }
          )

          ::Gpdb::REST::RecordingRequest::Response.new(client.request(request))
        end
      end
    end
  end
end
