class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
			t.datetime :begin_date
			t.datetime :end_date
      t.timestamps
    end
  end
end
