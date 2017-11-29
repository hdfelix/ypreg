class AddMaxCapacityToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :max_capacity, :integer
  end
end
