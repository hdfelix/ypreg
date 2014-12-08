require 'rails_helper'

describe Locality, type: :model do

  describe 'Associations' do
    it { should have_many :users }
    it { should have_many :lodgings }
    it { should have_many :hospitalities }
    it { should have_many :hospitality_assignments }
    it { should belong_to :contact }
    it { should belong_to :lodging_contact }
  end

  describe 'Validations' do
    it { should validate_presence_of :city }
    it { should validate_presence_of :state_abbrv }
  end

  # Scopes here...

  describe 'Interface' do
    describe '#display_contact' do
      it "returns the locality's contact name" do
        locality = create(:locality, contact: create(:user))
        expect(locality.display_contact).to eq(locality.contact.name)
      end

      it "returns '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.display_contact).to eq('--')
      end
    end

    describe '#display_contact_with_contact_info' do
      it "return '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.display_contact_with_contact_info).to eq('--')
      end

      it 'returns the name and e-mail of the locality contact' do
        locality = create(:locality, contact: create(:user))
        info = locality.contact.name + " (#{locality.contact.email})"
        expect(locality.display_contact_with_contact_info)
          .to eq(info)
      end
    end
  end
end
