class CreateJoinTableHospitalityAssignment < ActiveRecord::Migration
  def change
    create_table :hospitality_assignments do |t|
      t.references :hospitality, index: true
      t.references :registration, index: true
    end
  end
end
