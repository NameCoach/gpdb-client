# frozen_string_literal: true

module Gpdb
  module REST
    module Target
      class Model < ::Gpdb::Model
        attr_accessor :pagination_info, :origin, :links,
                      :transcription, :id, :pronunciations

        def initialize(attributes = {})
          self.pagination_info = attributes[:target_pagination_info]
          self.origin          = attributes[:target_origin]
          self.links           = attributes[:links]
          self.transcription   = attributes[:target_transcription]
          self.id              = attributes[:target_id]
          self.pronunciations  = attributes[:pronunciations].map do |pronunciation|
            ::Gpdb::REST::Pronunciation::Model.new(pronunciation)
          end
        end
      end
    end
  end
end
