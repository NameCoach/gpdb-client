# frozen_string_literal: true

module Gpdb
  class Model
    attr_accessor :created_at, :updated_at, :id

    def initialize(attributes = {})
      attributes.each do |name, value|
        public_send("#{name}=", value)
      end
    end
  end
end
