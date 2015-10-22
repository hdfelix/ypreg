class AddStatusesOnUsers < ActiveRecord::Migration
  def change
    enable_extension 'hstore'
    add_column :users, :statuses, :hstore
    add_index :users, :statuses, using: :gist
  end
end
