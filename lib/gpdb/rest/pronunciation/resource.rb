# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class Resource < Gpdb::REST::BaseResource
        # @param [String] target
        # @param [String] app_sig
        # @param [String] app_type
        # @param [Hash] options
        # @return [Gpdb::REST::Pronunciation::TargetResponse]
        def simple_search(target:, app_sig:, app_type:, **options)
          request = ::Gpdb::REST::Request.new(
            method: :get,
            path:   '/pronunciations',
            params: {
              target:               target,
              application_sig:      app_sig,
              application_type_sig: app_type
            }.merge(options)
          )

          ::Gpdb::REST::Pronunciation::TargetResponse.new(
            client.request(request, namespace: 'api/public/v1')
          )
        end

        # @param [Array] targets
        # @param [Object] application_context
        # @param [Object] user_context
        # @return [Gpdb::REST::Pronunciation::TargetListResponse]
        def complex_search(targets:, application_context:, user_context: {})
          request = ::Gpdb::REST::Request.new(
            method: :post,
            path:   '/pronunciations/search',
            params: {
              targets:             targets,
              application_context: application_context,
              user_context:        user_context
            }
          )

          ::Gpdb::REST::Pronunciation::TargetListResponse.new(
            client.request(request, namespace: 'api/public/v1')
          )
        end

        # @param [String] name
        # @param [String] base64_audio
        # @param [Object] application_context
        # @param [Object] user_context
        # @param [Hash] options
        # @return [Gpdb::REST::Pronunciation::Response]
        def create(name:, base64_audio:, application_context:, user_context:, **options)
          request = ::Gpdb::REST::Request.new(
            method: :post,
            path:   '/pronunciations',
            params: {
              name_text:           name,
              audio_data:          base64_audio,
              application_context: application_context,
              user_context:        user_context
            }.merge(options)
          )

          ::Gpdb::REST::Pronunciation::Response.new(
            client.request(request, namespace: 'api/public/v1')
          )
        end
      end
    end
  end
end
