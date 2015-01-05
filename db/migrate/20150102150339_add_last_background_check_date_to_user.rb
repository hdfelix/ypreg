class AddLastBackgroundCheckDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_background_check, :datetime
  end
end
