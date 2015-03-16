class AddHospitalitiesRefToRegistrations < ActiveRecord::Migration
  def change
    add_reference :registrations, :hospitality, index: true
    add_reference :registrations, :locality, index: true
  end
end
