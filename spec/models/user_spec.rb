require 'rails_helper'

describe User, type: :model do
  describe 'Constants' do
    it { should have_constant :USER_ROLE }
  end

  describe 'Validations'
  describe 'Associations' do
    it { should have_many :registrations }
    it { should have_many :events }
    it { should belong_to :locality }
    it { should belong_to :lodging }
  end
end
