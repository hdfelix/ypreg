# Model for a registration to an event
class Registration < ActiveRecord::Base
  PAYMENT_TYPE = ['Cash', 'Check']

  belongs_to :user
  belongs_to :event
  belongs_to :locality
  has_many :hospitality_registration_assignments, inverse_of: :registration
  # has_many :hospitalities, -> { uniq }, through: :hospitality_registration_assignments
  
  delegate :name, :email, :cell_phone, :home_phone, :work_phone, :birthday,
    :lodging_id, # ...
           to: :user
end
