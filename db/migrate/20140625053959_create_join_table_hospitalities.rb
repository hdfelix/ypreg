class CreateJoinTableHospitalities < ActiveRecord::Migration
  def change
    create_table :hospitalities do |t| #removed id: false...
			# t.index :event_id
			# t.index :lodging_id
      # t.index :locality_id
      t.references :event, index: true
      t.references :lodging, index: true
      t.references :locality, index: true
    end
  end
end
