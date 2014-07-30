class RemoveContactPersonIdFromHospitality < ActiveRecord::Migration
  def change
  	remove_column :hospitalities, :contact_person_id
  end
end
