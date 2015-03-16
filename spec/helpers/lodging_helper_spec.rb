require 'rails_helper'

describe LodgingHelper do
  describe '#contact_person_name' do
    it "returns a lodging contact person's" do
      person = create(:user, name: 'Hector')
      lodge = create(:lodging, contact_person: person)

      expect(contact_person_name(lodge)).to eq('Hector')
    end
  end
end
