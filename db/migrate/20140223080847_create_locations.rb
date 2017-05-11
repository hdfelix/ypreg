class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.text :description
      t.column :location_type, :integer, default: 0
      t.string :name
      t.string :state
      t.integer :zipcode

      t.timestamps
    end
  end
end
