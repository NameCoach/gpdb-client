# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::RecordingRequest::Model do
  describe '#attributes' do
    let(:instance) { described_class.new }

    it { expect(instance).to respond_to(:id) }
    it { expect(instance).to respond_to(:target) }
    it { expect(instance).to respond_to(:target_owner_context) }
    it { expect(instance).to respond_to(:user_context) }
    it { expect(instance).to respond_to(:application_context) }
    it { expect(instance).to respond_to(:target_owner_context) }
  end
end
