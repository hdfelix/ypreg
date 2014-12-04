# A hospitality assigment for an event
class HospitalityAssignment < ActiveRecord::Base
  belongs_to :registration
  belongs_to :hospitality
  belongs_to :locality

  def hospitality
    Hospitality.find(hospitality_id)
  end

  def registration
    Registration.find(registration_id)
  end

  def locality
    Locality.find(hospitality.locality_id)
  end


  def saint
    User.find(registration.user_id)
  end
end
