require 'spec_helper'

RSpec.describe Gpdb do
  describe '#configuration' do
    before do
      Gpdb.configure do |config|
        config.api_url = 'test_url'
        config.namespace = '/test/namespace'
        config.access_key_id = 'test_access_key'
        config.secret_access_key = 'test_secret_key'
      end
    end

    let(:config) { Gpdb.configuration }
    let(:credentials) { Gpdb::Credentials.new('test_access_key', 'test_secret_key') }

    it 'has actual variables' do
      expect(config.api_url).to eq 'test_url'
      expect(config.namespace).to eq '/test/namespace'
      expect(config.credentials.signature).to eq credentials.signature
    end
  end
end
