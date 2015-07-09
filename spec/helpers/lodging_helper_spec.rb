require 'rails_helper'

describe LodgingHelper do
  let(:contact_person) { build_stubbed(:user, name: 'Hector') }
  let(:lodging) { build_stubbed(:lodging, contact_person: contact_person) }
            
  describe '#contact_person_name' do
    it "returns a lodging contact person's name" do
      expect(contact_person_name(lodging)).to eq('Hector')
    end
  end

  describe '#filtered_contact_person_collection' do
    it 'returns a collection of users not assigned as contact_people' \
        'with the contact_person (if any) for the current lodging' do
      # TODO: figure out how to use mocks with class doubles to test this method
    end
  end
end
