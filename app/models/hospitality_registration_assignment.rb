class HospitalityRegistrationAssignment < ActiveRecord::Base
  belongs_to :registration
  belongs_to :hospitality
  belongs_to :locality
  belongs_to :event

  def saint
    User.find(registration.user_id)
  end
end
