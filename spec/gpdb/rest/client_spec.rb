require 'spec_helper'

RSpec.describe Gpdb::REST::Client do
  describe '#accessors' do
    let(:instance) { Gpdb::REST::Client.new }

    it { expect(instance).to respond_to(:recordings) }
    it { expect(instance).to respond_to(:external_uris) }
    it { expect(instance).to respond_to(:recording_requests) }
    it { expect(instance).to respond_to(:apps) }
    it { expect(instance).to respond_to(:recording_verifications) }
    it { expect(instance).to respond_to(:recording_verification_uri_refs) }
  end
end
