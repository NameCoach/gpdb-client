# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class Model < ::Gpdb::Model
        attr_accessor :id, :created_at, :updated_at, :audio_url, :allow_user_responses,
                      :language_metadata, :phonetic_transcriptions, :user_responses,
                      :audio_source, :audio_owner_signature, :name_owner_signature, :name_text

        def initialize(attributes = {})
          self.id                      = attributes[:id]
          self.audio_url               = attributes[:audio_url]
          self.allow_user_responses    = attributes[:allow_user_responses]
          self.language_metadata       = attributes[:language_metadata]
          self.phonetic_transcriptions = attributes[:phonetic_transcriptions]
          self.user_responses          = attributes[:user_responses]
          self.created_at              = attributes[:created_at]
          self.updated_at              = attributes[:updated_at]

          # The next attributes are present only for the 'create' action
          self.audio_source          = attributes[:audio_source]
          self.audio_owner_signature = attributes[:audio_owner_signature]
          self.name_owner_signature  = attributes[:name_owner_signature]
          self.name_text             = attributes[:name_text]
        end
      end
    end
  end
end
