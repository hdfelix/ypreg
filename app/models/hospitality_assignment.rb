class EventLodgingAssignment < ActiveRecord::Base
  belongs_to :registration, inverse_of: :event_lodging_assignments
  belongs_to :event_lodging, inverse_of: :event_lodging_assignments
  belongs_to :locality

  def event_lodging
    EventLodging.find(event_lodging_id)
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
