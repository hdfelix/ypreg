class AddMinCapacityToHospitality < ActiveRecord::Migration
  def change
    add_column :hospitalities, :min_capacity, :string
  end
end
