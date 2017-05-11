class CreateLodgings < ActiveRecord::Migration[5.0]
  def change
    create_table :lodgings do |t|
      t.text :description
      t.belongs_to :location, index: true
      t.integer :lodging_type, default: 0
      t.integer :max_capacity
      t.integer :min_capacity
      t.string :name

      t.timestamps
    end
  end
end
