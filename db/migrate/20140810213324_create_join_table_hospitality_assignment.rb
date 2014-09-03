class CreateJoinTableHospitalityAssignment < ActiveRecord::Migration
  def change
    create_table :hospitality_assignments do |t|
      t.references :hospitality, index: true
      t.references :registration, index: true
    end
    add_index :hospitality_assignments, ["hospitality_id", "registration_id"], unique: true, name: 'hosp_assignmts'
  end
end
