class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
			t.integer :location_id
			t.integer :event_type
			t.datetime :begin_date
			t.datetime :end_date
			t.decimal	:registration_cost
		  t.datetime :registration_open_date
			t.datetime :registration_close_date
      t.timestamps
    end
  end
end
