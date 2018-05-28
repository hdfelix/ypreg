require 'rails_helper'

describe Hospitality, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:event).inverse_of(:hospitalities) }
    it { is_expected.to belong_to :lodging }
    it { is_expected.to belong_to :locality.optional }
    it { is_expected.to belong_to(:registration).optional }
    it do
      is_expected.to have_many(:registrations)
        .through(:hospitality_registration_assignments)
        .conditions(:uniq)
    end
    it { is_expected.to have_many(:hospitality_registration_assignments).inverse_of(:hospitality) }
  end

  describe 'Delegations' do
    it { is_expected.to delegate_method(:name).to(:lodging) }
    it { is_expected.to delegate_method(:description).to(:lodging) }
    it { is_expected.to delegate_method(:address1).to(:lodging) }
    it { is_expected.to delegate_method(:address2).to(:lodging) }
    it { is_expected.to delegate_method(:city).to(:lodging) }
    it { is_expected.to delegate_method(:state_abbrv).to(:lodging) }
    it { is_expected.to delegate_method(:zipcode).to(:lodging) }
    it { is_expected.to delegate_method(:lodging_type).to(:lodging) }
    it { is_expected.to delegate_method(:locality_id).to(:lodging) }
    it { is_expected.to delegate_method(:min_capacity).to(:lodging) }
    it { is_expected.to delegate_method(:max_capacity).to(:lodging) }
  end

  describe 'after_destroy' do
    describe '#remove_associations' do
      context 'registrations assigned to this hospitality' do
        it 'sets hospitality and locality attribute to nil' do
          event = create(:event_with_registrations)
          registrations = event.registrations
          lodging = create(:lodging, max_capacity: registrations.count)
          hospitality = create(:hospitality, event: event, lodging: lodging)

          registrations_setup(event, registrations, hospitality)
          hospitality.destroy

          registrations.each do |reg|
            hra = HospitalityRegistrationAssignment.where(
              hospitality: hospitality, registration: reg)
            expect(reg.hospitality).to be_nil
            expect(hra).to be_empty
          end
        end
      end
    end
  end

  def registrations_setup(event, registrations, hospitality)
    registrations.each do |reg|
      reg.hospitality = hospitality
      HospitalityRegistrationAssignment
        .create(event: event, hospitality: hospitality, registration: reg)
    end
  end
end
