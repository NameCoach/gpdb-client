require 'spec_helper'

RSpec.describe GpdbClient do
  it 'has a version number' do
    expect(GpdbClient::VERSION).not_to be nil
  end
end
