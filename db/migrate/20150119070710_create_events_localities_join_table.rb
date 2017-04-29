class CreateEventsLocalitiesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :events_localities do |t|
      t.belongs_to :event, index: true
      t.belongs_to :locality, index: true
      t.boolean :submitted_registration_payment_check
      t.timestamps
    end
  end
end
