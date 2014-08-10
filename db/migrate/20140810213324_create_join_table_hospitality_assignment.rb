class CreateJoinTableHospitalityAssignment < ActiveRecord::Migration
  def change
    create_table :hospitality_assignments do |t|
      t.references :events_hospitalities, index: true
      t.references :registrations, index: true
    end
  end
end
