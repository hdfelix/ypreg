class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

	PAYMENT_TYPE = [['Cash',1],['Check',2]]
end
