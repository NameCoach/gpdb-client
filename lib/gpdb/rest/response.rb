# frozen_string_literal: true

module Gpdb
  module REST
    class Response < ::Gpdb::Model
      attr_accessor :body, :status, :_response, :errors

      delegate :success?, to: :_response

      def initialize(*args)
        if args[0].is_a?(Hash)
          super
        elsif args[0].is_a?(::Gpdb::REST::Response)
          super(
            body:      args[0].body,
            status:    args[0].status,
            _response: args[0]._response
          )
        end

        self.errors = body[:errors] if body.is_a?(Hash)
      end

      def to_s
        "<#{self.class} #{status} #{_response.reason_phrase} #{_response.headers['x-runtime']}s #{body.present? ? 'with body' : nil}>"
      end

      def inspect
        to_s
      end
    end
  end
end
