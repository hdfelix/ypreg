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

    describe '#not_contact_person_drop_down_collection' do
      it 'returns users that are not contact_person with self for Lodging _form
      contact person collection' do
        Lodging.delete_all
        User.delete_all
        lodge = create(:lodging)
        create(:lodging)
        user_list = create_list(:confirmed_user, 2)

        expect(lodge.contact_person.not_contact_person_drop_down_collection)
          .to eq(user_list + [lodge.contact_person])
      end
    end
  end
end
