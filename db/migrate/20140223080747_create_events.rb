class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
			t.integer :location_id
			t.integer :event_type
			t.date :begin_date
			t.date :end_date
			t.decimal	:registration_cost
		  t.date :registration_open_date
			t.date :registration_close_date
      t.timestamps
    end
	add_index :events, :location_id, name: 'location_id_ix'
  end
end
