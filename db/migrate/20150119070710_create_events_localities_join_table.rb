class CreateEventsLocalitiesJoinTable < ActiveRecord::Migration
  def change
    create_table :events_localities do |t|
      t.references :event, index: true
      t.references :locality, index: true
      t.boolean :submitted_registration_payment_check
    end
  end
end
