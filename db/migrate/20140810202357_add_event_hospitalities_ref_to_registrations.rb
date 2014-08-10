class AddEventHospitalitiesRefToRegistrations < ActiveRecord::Migration
  def change
    add_reference :registrations, :events_hospitalities, index: true
  end
end
