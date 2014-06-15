class CreateHospitalityHomes < ActiveRecord::Migration
  def change
    create_table :hospitality_homes do |t|
      t.string :name, null: false
      t.string :home_phone, limit: 10
      t.string :cell_phone, limit: 10
      t.string :email
			t.string :address, null: false
			t.string :city, null: false
			t.string :state_abbrv, limit: 2, null: false
			t.string :zipcode, limit: 5, null: false
      t.integer :minimum_capacity
      t.integer :maximum_capacity
      t.string :comments

      t.timestamps
    end
  end
end
