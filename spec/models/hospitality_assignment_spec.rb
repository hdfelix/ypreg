require 'rails_helper'

describe HospitalityAssignment, type: :model do

  # describe 'Associations' do
  #   it { should belong_to :registration }
  #   it { should belong_to :hospitality }
  #   # it { should belong_to :locality }
  # end

  # describe 'Interface' do
  #   describe '#hospitality' do
  #     it 'returns the hospitality instance for this HospitalityAssignment' do
  #       hosp = create(:hospitality)
  #       hosp_assignment = create(:hospitality_assignment, hospitality: hosp)

  #       expect(hosp_assignment.hospitality).to eq(hosp)
  #     end
  #   end
  #   describe '#registration' do
  #     it 'regurns the registartion instance for this HospitalityAssignment' do
  #       reg = create(:registration)
  #       hosp_assignment = create(:hospitality_assignment, registration: reg)

  #       expect(hosp_assignment.registration).to eq(reg)
  #     end
  #   end
  #   describe '#locality' do
  #     it 'returns the locality instance for this HospitalityAssignment' do
  #       loc = create(:locality)
  #       hosp_assignment = create(:hospitality_assignment, locality: loc)

  #       expect(hosp_assignment.locality).to eq(loc)
  #     end
  #   end
  #   describe '#saint' do
  #     it 'returns the saint in the registration for this HospitalityAssignment' do
  #       saint = create(:user)
  #       reg   = create(:registration, user: saint)
  #       hosp_assignment = create(:hospitality_assignment, registration: reg)

  #       expect(hosp_assignment.saint).to eq(saint)
  #     end
  #   end
  # end

end
