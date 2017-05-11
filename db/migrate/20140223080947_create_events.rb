class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.date :begin_date
      t.string :description
      t.date :end_date
      t.integer :event_type, default: 0
      t.belongs_to :location, index: true
      t.date :registration_close_date
      t.integer	:registration_cost
      t.date :registration_open_date
      t.string :title

      t.timestamps
    end
  end
end
