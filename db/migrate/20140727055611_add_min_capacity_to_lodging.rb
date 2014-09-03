class AddMinCapacityToLodging < ActiveRecord::Migration
  def change
    add_column :lodgings, :min_capacity, :string
  end
end
