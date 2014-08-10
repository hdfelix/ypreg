class CreateEventHospitalities < ActiveRecord::Migration
  def change
    create_table :event_hospitalities do |t| #removed id: false...
			t.integer :event_id
			t.integer :hospitality_id
    end
		add_index :events_hospitalities, ["event_id", "hospitality_id"]
	  add_index :events, :location_id, name: 'location_id_ix'
  end
end
