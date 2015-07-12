require 'rails_helper'

describe Locality, type: :model do

  describe 'Associations' do
    it { should have_many :users }
    it { should have_many :lodgings }
    it { should belong_to :contact }
    it { should belong_to :lodging_contact }
  end

  describe 'Validations' do
    it { should validate_presence_of :city }
    it { should validate_presence_of :state_abbrv }
  end

  # Scopes here...

  describe 'Interface' do
    describe '#display_contact_name' do
      it "returns the locality's contact name" do
        locality = create(:locality, contact: create(:user, name: 'Bob'))
        expect(locality.contact_name).to eq(locality.contact.name)
      end

      it "returns '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.contact_name).to eq('--')
      end
    end

    describe '#contact_with_email' do
      it 'returns the name and e-mail of the locality contact' do
        locality = create(:locality, contact: create(:user))
        info = locality.contact.name + " (#{locality.contact.email})"
        expect(locality.contact_with_email)
          .to eq(info)
      end

      it "return '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.contact_with_email).to eq('--')
      end
    end

    describe '#contact_with_email_and_cell' do
      it 'returns the name, e-mail, and cell of the locality contact' do
        locality = create(:locality, contact: create(:user, cell_phone: '8888888888'))
        c = locality.contact
        contact_string = "#{c.name} (#{c.email}, (888) 888-8888)"
        expect(locality.contact_with_email_and_cell)
          .to eq(contact_string)
      end

      it "return '--' if locality has no contact" do
        locality = create(:locality)
        expect(locality.contact_with_email).to eq('--')
      end
    end

    describe '#hospitalities'
    describe '#hospitality_lodgings'
    describe '#registrations' do
      it 'returns registrations from this locality for a given event' do
        ev   = create(:event)
        loc  = create(:locality)
        user = create(:user, locality: loc)
        reg  = create(:registration, event: ev, locality: loc, user: user)

        expect(loc.registrations(ev)).to eq([reg])
      end
    end
  end
end
