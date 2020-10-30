# frozen_string_literal: true

module Gpdb
  class HttpClient
    class JsonParseMiddleware < ::Faraday::Response::Middleware
      def on_complete(env)
        env[:body] = JSON.parse(env[:body], symbolize_names: true) if env.parse_body?
      end
    end

    class HeadersMiddleware < ::Faraday::Middleware
      def call(env)
        env[:request_headers]['Content-Type'] = if [:post, :put].include?(env.method)
                                                  'multipart/form-data'
                                                else
                                                  'application/json'
                                                end

        env[:request_headers]['Accept'] = 'application/json'
        env[:request_headers]['User-Agent'] = "gpdb-api-client/#{GpdbSdkRuby::VERSION}"

        @app.call(env)
      end
    end

    def request(request)
      conn = Faraday.new(url: request.api_url) do |f|
        f.headers = request.headers
        f.use(HeadersMiddleware)

        f.request(:multipart)
        f.request(:url_encoded)

        f.use(JsonParseMiddleware)
        f.adapter(Faraday.default_adapter)
      end

      conn.public_send(request.method, request.path, request.params)
    end
  end
end
