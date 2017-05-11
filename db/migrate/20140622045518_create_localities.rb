class CreateLocalities < ActiveRecord::Migration[5.0]
  def change
    create_table :localities do |t|
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
