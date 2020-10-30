require 'bundler/setup'
Bundler.setup

require 'gpdb_sdk_ruby'
require 'active_support/core_ext/numeric/time'

ENV['GPDB_API_URL'] = 'http://localhost'
ENV['GPDB_NAMESPACE'] = '/test/api/v1'
ENV['GPDB_ACCESS_KEY_ID'] = 'access_key_id'
ENV['GPDB_SECRET_ACCESS_KEY'] = 'secret_access_key'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
