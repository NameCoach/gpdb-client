# frozen_string_literal: true

module Gpdb
  class Configuration
    include Singleton

    attr_accessor :namespace
    attr_accessor :api_url
    attr_accessor :access_key_id
    attr_accessor :secret_access_key

    def initialize
      self.api_url = ENV.fetch('GPDB_API_URL')
      self.namespace = ENV.fetch('GPDB_NAMESPACE')
      self.access_key_id = ENV.fetch('GPDB_ACCESS_KEY_ID')
      self.secret_access_key = ENV.fetch('GPDB_SECRET_ACCESS_KEY')
    end

    def credentials
      Credentials.new(access_key_id, secret_access_key)
    end
  end
end
