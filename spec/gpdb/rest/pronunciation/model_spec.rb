# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::Pronunciation::Model do
  describe '#attributes' do
    let(:instance) { described_class.new }

    it { expect(instance).to respond_to(:id) }
    it { expect(instance).to respond_to(:audio_url) }
    it { expect(instance).to respond_to(:allow_user_responses) }
    it { expect(instance).to respond_to(:language_metadata) }
    it { expect(instance).to respond_to(:phonetic_transcriptions) }
    it { expect(instance).to respond_to(:user_responses) }
    it { expect(instance).to respond_to(:created_at) }
    it { expect(instance).to respond_to(:updated_at) }
  end
end
