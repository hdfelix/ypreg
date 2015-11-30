class AddVehicleSeatingCapacityToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :vehicle_seating_capacity, :integer
  end
end
