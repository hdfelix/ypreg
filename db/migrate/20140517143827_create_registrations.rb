class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.belongs_to :event_locality, index: true
      t.belongs_to :event_lodging, index: true
      t.boolean :guest, default: false
      t.boolean :medical_release, default: false
      t.boolean :paid, default: false
      t.integer :payment_type, default: 0
      t.integer :payment_adjustment, default: 0
      t.boolean :serving_one, default: false
      t.integer :status
      t.belongs_to :user, index: true
      t.integer :vehicle_seating_capacity

      t.timestamps
    end
  end
end
