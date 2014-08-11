class CreateLodgings < ActiveRecord::Migration
  def change
    create_table :lodgings do |t|
      t.string :name
      t.text :description
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_abbrv
      t.integer :zipcode
      t.string :lodging_type
			t.integer :locality_id
      t.string :max_capacity
    end
  end
end
