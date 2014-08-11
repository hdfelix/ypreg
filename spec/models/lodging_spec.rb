require 'rails_helper'

describe Lodging, type: :model do
  it 'has a valid factory' do
    expect(build(:lodging)).to be_valid
  end
end
