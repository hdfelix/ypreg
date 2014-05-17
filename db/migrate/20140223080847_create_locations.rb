class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
			t.text :description
			t.integer :address_id
      t.timestamps
    end
	add_index :locations, :address_id
  end
end
