# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class Model < ::Gpdb::Model
        attr_accessor :id, :created_at, :updated_at, :audio_url, :allow_user_responses,
                      :language_metadata, :phonetic_transcriptions, :user_responses

        def initialize(attributes = {})
          self.id                      = attributes[:id]
          self.audio_url               = attributes[:audio_url]
          self.allow_user_responses    = attributes[:allow_user_responses]
          self.language_metadata       = attributes[:language_metadata]
          self.phonetic_transcriptions = attributes[:phonetic_transcriptions]
          self.user_responses          = attributes[:user_responses]
          self.created_at              = attributes[:created_at]
          self.updated_at              = attributes[:updated_at]
        end
      end
    end
  end
end
