require 'rails_helper'

describe Hospitality, type: :model do
  it 'has a valid factory' do
    expect(build(:hospitality)).to be_valid
  end
end
