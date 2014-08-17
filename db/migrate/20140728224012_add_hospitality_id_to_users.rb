class AddHospitalityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hospitality_id, :integer
  end
end
