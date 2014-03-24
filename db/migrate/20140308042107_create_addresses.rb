class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
			t.string :addressline1
			t.string :addressline2
			t.string :city
			t.integer :state_id
			t.integer :zipcode

      t.timestamps
    end
		add_index :addresses, :state_id, name: 'state_id_ix'
  end
end
