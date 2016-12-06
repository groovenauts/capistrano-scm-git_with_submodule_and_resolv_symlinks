require 'spec_helper'

describe Example do
  it 'has a version number' do
    expect(Example::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
