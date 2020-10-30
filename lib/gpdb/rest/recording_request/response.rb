# frozen_string_literal: true

module Gpdb
  module REST
    module RecordingRequest
      class Response < ::Gpdb::REST::Response
        attr_accessor :recording_request

        def initialize(*args)
          super
          self.recording_request = Gpdb::REST::RecordingRequest::Model.new(body) if success?
        end
      end
    end
  end
end
