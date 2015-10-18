class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :string
  end
end
