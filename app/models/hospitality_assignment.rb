class HospitalityAssignment < ApplicationRecord
  belongs_to :registration, inverse_of: :hospitality_assignments
  belongs_to :hospitality, inverse_of: :hospitality_assignments
  belongs_to :locality

  def hospitality
    Hospitality.find(hospitality_id)
  end

  def registration
    Registration.find(registration_id)
  end

  def locality
    Locality.find(locality_id)
  end

  def saint
    User.find(registration.user_id)
  end
end
