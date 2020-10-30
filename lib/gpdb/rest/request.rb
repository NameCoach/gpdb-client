# frozen_string_literal: true

module Gpdb
  module REST
    class Request < ::Gpdb::Model
      attr_accessor :api_url, :path, :params, :method, :headers

      def method
        @method.downcase.to_sym
      end
    end
  end
end
