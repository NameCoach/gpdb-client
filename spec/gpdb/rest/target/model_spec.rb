# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Gpdb::REST::Target::Model do
  describe '#attributes' do
    let(:instance) { described_class.new }

    it { expect(instance).to respond_to(:id) }
    it { expect(instance).to respond_to(:pagination_info) }
    it { expect(instance).to respond_to(:origin) }
    it { expect(instance).to respond_to(:links) }
    it { expect(instance).to respond_to(:transcription) }
    it { expect(instance).to respond_to(:pronunciations) }

    context 'when pronunciations are provided' do
      let(:pronunciation_attributes) do
        [
          { id: 1, audio_url: 'audio_url_1' },
          { id: 2, audio_url: 'audio_url_2' }
        ]
      end

      let(:instance) { described_class.new(pronunciations: pronunciation_attributes) }

      it 'initializes pronunciation models with the given attributes' do
        expect(instance.pronunciations).to be_an Array
        expect(instance.pronunciations).to all(be_a Gpdb::REST::Pronunciation::Model)
      end
    end
  end
end
