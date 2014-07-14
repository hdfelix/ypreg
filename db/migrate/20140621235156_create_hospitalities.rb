class CreateHospitalities < ActiveRecord::Migration
  def change
    create_table :hospitalities do |t|
      t.string :name
      t.text :description
      t.integer :contact_person_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_abbrv
      t.integer :zipcode
      t.string :hospitality_type
			t.integer :locality_id
      t.string :max_capacity
    end
  end
end
