# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class TargetResponse < ::Gpdb::REST::Response
        attr_accessor :target, :meta

        def initialize(*args)
          super

          return unless success?

          self.target = ::Gpdb::REST::Pronunciation::Target.new(body[:target_result])
          self.meta = body[:meta]
        end
      end
    end
  end
end
