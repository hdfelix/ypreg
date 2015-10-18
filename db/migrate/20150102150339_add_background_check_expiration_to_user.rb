class AddBackgroundCheckExpirationToUser < ActiveRecord::Migration
  def change
    add_column :users, :background_check_expiration, :datetime
  end
end
