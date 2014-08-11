class CreateHospitalities < ActiveRecord::Migration
  def change
    create_table :hospitalities do |t| #removed id: false...
			t.integer :event_id
			t.integer :lodging_id
    end
		add_index :hospitalities, ["event_id", "lodging_id"]
	  add_index :events, :location_id, name: 'location_id_ix'
  end
end
