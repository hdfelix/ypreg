class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locality_id, :integer
		add_column :users, :user_type, :string 
    add_column :users, :home_phone, :decimal
    add_column :users, :cell_phone, :decimal
    add_column :users, :work_phone, :decimal
    add_column :users, :birthday, :date
  end
end
