class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|

      t.timestamps
    end
  end
end
