# frozen_string_literal: true

module Gpdb
  class Credentials
    def initialize(access_key_id, secret_access_key)
      @access_key_id = access_key_id
      @secret_access_key = secret_access_key
    end

    def signature
      ::JWT.encode(
        { ts: Time.now.since(30.seconds).to_i * 1000 },
        @secret_access_key,
        'HS256',
        { access_key_id: @access_key_id }
      )
    end

    def signature_header
      "Bearer:#{signature}"
    end

    def signature_url_encoded
      { signature: signature }.to_query
    end
  end
end
