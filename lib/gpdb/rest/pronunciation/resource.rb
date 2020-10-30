# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class Resource < Gpdb::REST::BaseResource
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

          ::Gpdb::REST::Pronunciation::ListResponse.new(
            client.request(request, namespace: 'api/public/v1')
          )
        end
      end
    end
  end
end
