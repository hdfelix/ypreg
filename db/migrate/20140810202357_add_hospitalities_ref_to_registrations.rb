class AddHospitalitiesRefToRegistrations < ActiveRecord::Migration
  def change
    add_reference :registrations, :hospitality, index: true
  end
end
