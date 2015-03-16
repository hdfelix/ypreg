class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_phone, :string
    add_column :users, :cell_phone, :string
    add_column :users, :work_phone, :string
    add_column :users, :birthday, :date
  end
end
