# frozen_string_literal: true

module Gpdb
  module REST
    module RecordingRequest
      class Model < ::Gpdb::Model
        attr_accessor :name, :user_id

        def initialize(attributes = {})
          self.id      = attributes[:id]
          self.name    = attributes[:name]
          self.user_id = attributes[:user_id]

          self.created_at = attributes[:created_at]
          self.updated_at = attributes[:updated_at]
        end
      end
    end
  end
end
