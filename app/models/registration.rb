class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :hospitality_assignments
  has_many :hospitalities, -> { uniq }, through: :hospitality_assignments

	PAYMENT_TYPE = [['Cash',1],['Check',2]]
end
