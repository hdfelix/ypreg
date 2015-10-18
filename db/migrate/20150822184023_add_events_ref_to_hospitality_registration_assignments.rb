class AddEventsRefToHospitalityRegistrationAssignments < ActiveRecord::Migration
  def change
    add_reference :hospitality_registration_assignments, :event, index: true
  end
end
