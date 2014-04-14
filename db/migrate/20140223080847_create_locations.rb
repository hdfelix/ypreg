class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
			t.string :description
			t.string :address1
			t.string :address2
			t.string :city
			t.string :state_abbrv
			t.integer :zipcode

      t.timestamps
    end
  end
end
