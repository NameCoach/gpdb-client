# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class TargetListResponse < ::Gpdb::REST::Response
        attr_accessor :target_results, :meta

        def initialize(*args)
          super

          return unless success?

          self.target_results = body[:target_results].map { |target| ::Gpdb::REST::Pronunciation::Target.new(target) }
          self.meta = body[:meta]
        end
      end
    end
  end
end
