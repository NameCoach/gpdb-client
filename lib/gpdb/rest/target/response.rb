# frozen_string_literal: true

module Gpdb
  module REST
    module Target
      class Response < ::Gpdb::REST::Response
        attr_accessor :target, :meta

        def initialize(*args)
          super

          return unless success?

          self.target = ::Gpdb::REST::Target::Model.new(body[:target_result])
          self.meta = body[:meta]
        end
      end
    end
  end
end
