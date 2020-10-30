# frozen_string_literal: true

module Gpdb
  module REST
    class BaseResource
      attr_accessor :client

      def initialize(api_client)
        self.client = api_client
      end
    end
  end
end
