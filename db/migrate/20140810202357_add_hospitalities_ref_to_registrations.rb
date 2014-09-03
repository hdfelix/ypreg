class AddHospitalitiesRefToRegistrations < ActiveRecord::Migration
  def change
    add_reference :registrations, :hospitalities, index: true
  end
end
