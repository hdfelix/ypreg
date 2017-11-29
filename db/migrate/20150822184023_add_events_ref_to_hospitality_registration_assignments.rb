class AddEventsRefToHospitalityRegistrationAssignments < ActiveRecord::Migration[5.0]
  def change
    add_reference :hospitality_registration_assignments, :event, index: true
  end
end
