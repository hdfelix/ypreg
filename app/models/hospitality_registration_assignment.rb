class EventLodgingRegistrationAssignment < ActiveRecord::Base
  belongs_to :registration
  belongs_to :event_lodging
  belongs_to :locality
  belongs_to :event

  def saint
    User.find(registration.user_id)
  end
end
