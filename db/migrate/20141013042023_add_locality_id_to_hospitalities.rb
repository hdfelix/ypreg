class AddLocalityIdToHospitalities< ActiveRecord::Migration
  def change
    add_column :hospitalities, :locality_id, :integer
    add_index :hospitalities, :locality_id
  end
end
