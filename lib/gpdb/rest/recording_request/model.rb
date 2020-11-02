# frozen_string_literal: true

module Gpdb
  module REST
    module RecordingRequest
      class Model < ::Gpdb::Model
        attr_accessor :recording_request_id, :target, :target_type_sig,
                      :target_owner_context, :user_context, :application_context

        def initialize(attributes = {})
          self.id                   = attributes[:recording_request_id]
          self.target               = attributes[:target]
          self.target_type_sig      = attributes[:target_owner_context]
          self.user_context         = attributes[:user_context]
          self.application_context  = attributes[:application_context]
          self.target_owner_context = attributes[:target_owner_context]
        end
      end
    end
  end
end
