class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.datetime :registration_date
      t.decimal :payment_type
      t.boolean :has_been_paid
      t.decimal :payment_adjustment
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
