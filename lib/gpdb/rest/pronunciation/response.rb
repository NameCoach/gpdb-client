# frozen_string_literal: true

module Gpdb
  module REST
    module Pronunciation
      class Response < ::Gpdb::REST::Response
        attr_accessor :pronunciation

        def initialize(*args)
          super

          self.pronunciation = Gpdb::REST::Pronunciation::Model.new(body) if success?
        end
      end
    end
  end
end
