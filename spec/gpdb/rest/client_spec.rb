require 'spec_helper'

RSpec.describe Gpdb::REST::Client do
  describe '#accessors' do
    let(:instance) { described_class.new }

    it { expect(instance).to respond_to(:recording_requests) }
    it { expect(instance).to respond_to(:pronunciations) }
  end
end
