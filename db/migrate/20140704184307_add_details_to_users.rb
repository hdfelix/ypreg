class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :locality, index: true
    add_column :users, :home_phone, :decimal
    add_column :users, :cell_phone, :decimal
    add_column :users, :work_phone, :decimal
    add_column :users, :birthday, :date
  end
end
