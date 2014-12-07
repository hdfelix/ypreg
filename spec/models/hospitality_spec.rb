require 'rails_helper'

describe Hospitality, type: :model do

  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :lodging }
    it { should belong_to :locality }
    it { should have_many :hospitality_assignments }
    it { should have_many(:registrations).through(:hospitality_assignments) }
  end

  describe 'Interface' do
    describe '#lodging' do
      it 'returns the lodging represented by the Hospitality instance' do
        lodging = create(:lodging)
        hospitality = create(:hospitality, lodging: lodging)

        expect(hospitality.lodging).to eq(lodging)
      end
    end

    describe '#hosted_locality' do
      it 'returns the locality being hosted at the hospitality instance' do
        locality = create(:locality)
        hospitality = create(:hospitality, locality: locality)

        expect(hospitality.hosted_locality).to eq(locality)
      end
    end
  end
end
