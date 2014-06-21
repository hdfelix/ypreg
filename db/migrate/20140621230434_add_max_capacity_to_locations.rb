class AddMaxCapacityToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :max_capacity, :integer
  end
end
