require 'rails_helper'

describe HospitalityRegistrationAssignment, type: :model do
  describe 'Associations' do
    it { should belong_to :registration }
    it { should belong_to :hospitality }
    it { should belong_to :locality }
    it { should belong_to :event }
  end

  describe 'Interface' do
    describe '#saint' do
      it 'returns the saint in the registration for this HospitalityAssignment' do
        saint = create(:user)
        reg   = create(:registration, user: saint)
        hosp_reg_assignment = create(:hospitality_registration_assignment, registration: reg)

        expect(hosp_reg_assignment.saint).to eq(saint)
      end
    end
  end
end
