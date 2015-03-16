class CreateHospitalityRegistrationAssignments < ActiveRecord::Migration
  def change
    create_table :hospitality_registration_assignments do |t|
      t.references :hospitality, index: true
      t.references :registration, index: true
      t.references :locality, index: true
    end
    add_index :hospitality_registration_assignments, ["hospitality_id", "registration_id", "locality_id"], unique: true, name: 'hosp_assignmts'
  end
end
