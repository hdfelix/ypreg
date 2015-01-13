class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :payment_type
      t.boolean :has_been_paid
      t.integer :payment_adjustment
      t.boolean :attend_as_serving_one
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
