class AddLocalityIdToHospitalityAssignments < ActiveRecord::Migration
  def change
    add_column :hospitality_assignments, :locality_id, :integer
    add_index :hospitality_assignments, :locality_id
  end
end
