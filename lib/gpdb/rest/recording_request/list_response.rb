# frozen_string_literal: true

module Gpdb
  module REST
    module RecordingRequest
      class ListResponse < ::Gpdb::REST::Response
        attr_accessor :recording_requests

        def initialize(*args)
          super

          if success?
            self.recording_requests = body.map do |attributes|
              ::Gpdb::REST::RecordingRequest::Model.new(attributes)
            end
          end
        end
      end
    end
  end
end
