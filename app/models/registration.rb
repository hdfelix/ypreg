# Model for a registration to an event
class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :hospitality_assignments
  has_many :hospitalities, -> { uniq }, through: :hospitality_assignments

  delegate :name, :email, :cell_phone, :home_phone, :work_phone, :birthday, #...
           to: :user
  PAYMENT_TYPE = [['Cash', 1], ['Check', 2]]
end
