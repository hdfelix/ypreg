require 'rails_helper'

describe Lodging, type: :model do
  describe 'Constants' do
    it { should have_constant :LODGING_TYPE }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state_abbrv }
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :lodging_type }
    it { should validate_presence_of :contact_person }
    it { should validate_presence_of :min_capacity }
  end

  describe 'Associations' do
    it { should belong_to :locality }
    it { should belong_to :contact_person }
    it { should accept_nested_attributes_for :contact_person }
  end

  describe 'Scopes' do
    describe '#users_that_are_not_contact_people' do
      it 'returns users that are not contact_persons' do
        Lodging.delete_all
        User.delete_all
        lodge = create(:lodging)
        create(:lodging)
        user_list = create_list(:confirmed_user, 2)

        expect(lodge.users_that_are_not_contact_people)
          .to eq(user_list + [lodge.contact_person])
      end
    end
  end

  describe 'Interface' do
    describe '#display_address_in_address_block_format' do
      it 'displays the lodging address' do
        lodging = FactoryGirl.create(:lodging)
        formatted_address =
          "#{lodging.address1}\n#{lodging.city}, #{lodging.state_abbrv}  #{lodging.zipcode}"

        expect(lodging.display_address_in_address_block_format)
          .to eq(formatted_address)
      end
    end

    describe '#display_description' do
      it 'displays the lodging description' do
        lodging = FactoryGirl.create(:lodging, description: 'My lodging')

        expect(lodging.display_description).to eq ('My lodging')
      end

      it "displays '--' if the lodging has no description" do
        lodging = create(:lodging, description: nil)

        expect(lodging.display_description).to eq('--')
      end
    end

    describe '#contact_person_home_phone' do
      it "displays the home phone number for the lodge's contact person" do
        usr = create(:user, home_phone: '888_888_8888')
        lodging = create(:lodging, contact_person: usr)

        expect(lodging.contact_person.home_phone).to eq('888_888_8888')
      end

      it "displays '--' if home phone number is nil" do
        usr = create(:user)
        lodging = create(:lodging, contact_person: usr)

        expect(lodging.contact_person_home_phone).to eq('--')
      end
    end

    describe '#contact_person_cell_phone' do
      it "displays the cell phone number for the lodge's contact person" do
        usr = create(:user, cell_phone: '888_888_8888')
        lodging = create(:lodging, contact_person: usr)

        expect(lodging.contact_person.cell_phone).to eq('888_888_8888')
      end

      it "displays '--' if cell phone number is nil" do
        usr = create(:user)
        lodging = create(:lodging, contact_person: usr)

        expect(lodging.contact_person_cell_phone).to eq('--')
      end
    end
    describe '#address' do
      it 'displays the complete lodging address in a string' do
        lodging = create(:lodging)

        address =
          lodging.address1 + ' ' +
          lodging.city + ', ' +
          lodging.state_abbrv + '  ' +
          lodging.zipcode.to_s

        expect(lodging.address).to eq(address)
      end
    end

    describe '#display_min_capacity' do
      it 'displays the minimum no. of beds available for hospitality' do
        lodging = create(:lodging, min_capacity: 2)

        expect(lodging.display_min_capacity).to eq(2)
      end
    end

    describe '#display_max_capacity' do
      it 'displays the max no. of beds available for hospitality' do
        lodging = create(:lodging, max_capacity: 2)

        expect(lodging.display_max_capacity).to eq(2)
      end

      it "displays '--' if no maximum capacity is recorded" do
        lodging = create(:lodging, max_capacity: nil)
        expect(lodging.display_max_capacity).to eq('--')
      end
    end
  end
end
