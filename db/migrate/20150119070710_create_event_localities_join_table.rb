class CreateEventLocalitiesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :event_localities do |t|
      t.belongs_to :event, index: true
      t.belongs_to :locality, index: true
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
