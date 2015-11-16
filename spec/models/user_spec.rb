require 'rails_helper'

describe User, type: :model do
  describe 'Associations' do
    it { should have_many :registrations }
    it { should have_many(:events).through(:registrations) }
    it { should belong_to :locality }
  end

  describe 'Validations' do
    it { should validate_presence_of :locality }
    it { should validate_presence_of :gender }
  end

  describe 'Constants' do
    it { should have_constant :USER_ROLE }
    it { should have_constant :GENDER }
    it { should have_constant :AGE }
    it { should have_constant :GRADE }
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

  describe 'Search scopes' do
    describe 'multisearchable' do
      it 'searches against :gender'
      it 'searches against :role'
    end
  end

  describe 'Interface' do
    describe '#role?'
    describe '#locality_city'
    describe '#registration' do
      it "returns the registration for the user to the event passed as a parameter" do
        event         = create(:event_with_registrations, registrations_count: 1)
        registration  = event.registrations.first
        user          = registration.user

        expect(user.registration(event)).to eq(registration)
      end
    end

    describe '#hospitality_registration_assginment'
    describe '#assigned_hospitality'
    describe '#background_check_valid?' do
      it 'returns true for those 17 years or younger' do
        user = create(:user, age: '17')
        expect(user.background_check_valid?). to be true
      end

      it 'returns true if the last background check date is less than 3 years ago' do
        user = create(:user, age: '18', background_check_date: 2.years.ago)
        expect(user.background_check_valid?). to be true
      end

      it 'returns false if the last background check was over 3 years ago' do
        user = create(:user, age: '18', background_check_date: 4.years.ago)
        expect(user.background_check_valid?). to be false
      end
    end

    describe '#hospitality'
  end
end
