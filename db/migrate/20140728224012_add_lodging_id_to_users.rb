class AddLodgingIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lodging_id, :integer
  end
end
