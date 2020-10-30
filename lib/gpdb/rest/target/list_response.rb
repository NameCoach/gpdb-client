# frozen_string_literal: true

module Gpdb
  module REST
    module Target
      class ListResponse < ::Gpdb::REST::Response
        attr_accessor :target_results, :meta

        def initialize(*args)
          super

          return unless success?

          self.target_results = body[:target_results].map { |target| ::Gpdb::REST::Target::Model.new(target) }
          self.meta = body[:meta]
        end
      end
    end
  end
end
