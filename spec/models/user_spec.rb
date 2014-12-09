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
  describe 'Scopes' do
    describe 'is_not_contact_person' do
      it 'returns uses that are not a Lodging ContactPerson' do
        User.delete_all
        Lodging.delete_all
        usr1 = create(:user)
        usr2 = create(:user)
        create(:lodging, contact_person: usr1)

        expect(User.is_not_contact_person).to eq([usr2])
      end
    end
  end
end
