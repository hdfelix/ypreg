class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :age, :integer, default: 0
    add_column :users, :avatar, :string
    add_column :users, :background_check_date, :datetime
    add_column :users, :birthday, :date
    add_column :users, :cell_phone, :string
    add_column :users, :gender, :integer, default: 0
    add_column :users, :grade, :integer, default: 0
    add_column :users, :home_phone, :string
    add_column :users, :work_phone, :string
  end
end
