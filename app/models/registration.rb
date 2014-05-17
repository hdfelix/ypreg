class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

	PAYMENT_TYPE = ['Cash','Check']
end
