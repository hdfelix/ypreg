class AddHospitalityIndextoUsers < ActiveRecord::Migration
  def change
  	add_index("users", "hospitality_id")
  end
end
