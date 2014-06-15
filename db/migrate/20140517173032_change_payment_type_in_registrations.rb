class ChangePaymentTypeInRegistrations < ActiveRecord::Migration
  def change
		change_column :registrations, :payment_type, :string
  end
end
