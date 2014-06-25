class CreateEventsHospitalities < ActiveRecord::Migration
  def change
    create_table :events_hospitalities do |t|
			t.integer :event_id
			t.integer :hospitality_id
    end
  end
end
