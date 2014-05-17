class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
			t.string :addressline1
			t.string :addressline2
			t.string :city
			t.string :state_abbrv
			t.integer :zipcode

      t.timestamps
    end
  end
end
