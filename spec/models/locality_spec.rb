require 'rails_helper'

describe Locality, type: :model do
  it 'it has a valid factory' do
    expect(build(:locality)).to be_valid
  end

  it 'is valid with city, state_abbrv' do
    expect(build(:locality, city: 'Newington', state_abbrv: 'CT')).to be_valid
  end

  it 'is invalid without a city' do
    expect(build(:locality, city: nil)).to_not be_valid
  end

  it 'is invalid without a state_abbrv' do
    expect(build(:locality, state_abbrv: nil)).to_not be_valid
  end
end
