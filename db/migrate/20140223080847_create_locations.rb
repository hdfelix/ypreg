class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
			t.string :description
			t.integer :address_id
      t.timestamps
    end
  end

	add_index :locations, :address_id
end
