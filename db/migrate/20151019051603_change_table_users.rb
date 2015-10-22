class ChangeTableUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :background_check_expiration, :background_check_date
    end
  end
end
