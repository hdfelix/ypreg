class CreateJoinTableEventLodgings < ActiveRecord::Migration[5.0]
  def change
    create_table :event_lodgings do |t|
      t.belongs_to :event, index: true
      t.belongs_to :lodging, index: true

      t.timestamps
    end
  end
end
