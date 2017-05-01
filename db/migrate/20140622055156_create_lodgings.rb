class CreateLodgings < ActiveRecord::Migration
  def change
    create_table :lodgings do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.text :description
      t.integer :min_capacity
      t.integer :max_capacity
      t.string :name
      t.string :state_abbrv
      t.string :lodging_type
      t.integer :zipcode
    end
  end
end
