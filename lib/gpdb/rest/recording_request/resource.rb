# frozen_string_literal: true

module Gpdb
  module REST
    module RecordingRequest
      class Resource < Gpdb::REST::BaseResource
        # @param [String] target
        # @param [String] target_type_sig
        # @param [Object] target_owner_context
        # @param [Object] application_context
        # @param [Object] user_context
        # @return [Gpdb::REST::RecordingRequest::Response]
        def create(target:, target_type_sig:, target_owner_context:, application_context:, user_context:)
          request = ::Gpdb::REST::Request.new(
            method: :post,
            path:   '/recording_requests',
            params: {
              target:               target,
              target_type_sig:      target_type_sig,
              target_owner_context: target_owner_context,
              application_context:  application_context,
              user_context:         user_context
            }
          )

          ::Gpdb::REST::RecordingRequest::Response.new(
            client.request(request, namespace: 'api/public/v1')
          )
        end
      end
    end
  end
end
