class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :hospitality_assignment
  has_one :hospitality, through: :hospitality_assignments

	PAYMENT_TYPE = [['Cash',1],['Check',2]]
end
