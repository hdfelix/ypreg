require 'rails_helper'

describe User, type: :model do
  describe 'Constants' do
    it { should have_constant :USER_ROLE }
    it { should have_constant :GENDER }
  end

  describe 'Validations'

  describe 'Associations' do
    it { should have_many :registrations }
    it { should have_many(:events).through(:registrations) }
    it { should belong_to :locality }
  end
  describe 'Scopes' do
    describe 'not_contact_persons' do
      it 'returns users that are not a Lodging ContactPerson' do
        User.delete_all
        Lodging.delete_all
        usr1 = create(:user)
        usr2 = create(:user)
        create(:lodging, contact_person: usr1)
        expect(User.not_contact_persons).to eq([usr2])
      end
    end
  end

  describe 'Interface' do
    describe '#registration' do
      it "returns the registration for the user to the event passed as a parameter" do
        event         = create(:event_with_registrations, registrations_count: 1)
        registration  = event.registrations.first
        user          = registration.user

        expect(user.registration(event)).to eq(registration)
      end
    end
  end
end
