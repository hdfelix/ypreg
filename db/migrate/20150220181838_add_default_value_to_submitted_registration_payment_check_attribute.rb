class AddDefaultValueToSubmittedRegistrationPaymentCheckAttribute < ActiveRecord::Migration
  def change
    change_column_default :events_localities, :submitted_registration_payment_check, false
  end
end
