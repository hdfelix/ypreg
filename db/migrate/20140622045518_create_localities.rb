class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.string :city
      t.string :state_abbrv
      t.integer :contact_id

      t.timestamps
    end
  end
end
