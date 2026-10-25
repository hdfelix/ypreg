require 'rails_helper'

describe HospitalityRegistrationAssignment, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :registration }
    it { is_expected.to belong_to :hospitality }
    it { is_expected.to belong_to :locality }
    it { is_expected.to belong_to :event }
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
