require 'rails_helper'

describe Hospitality, type: :model do
  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :lodging }
    it { should belong_to :locality }
    it { should belong_to :registration }
    it do
      should have_many(:registrations)
        .through(:hospitality_registration_assignments)
        .conditions(:uniq)
    end
    it { should have_many :hospitality_registration_assignments }
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
