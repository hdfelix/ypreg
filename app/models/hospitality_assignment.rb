class HospitalityAssignment < ActiveRecord::Base
  belongs_to :registration
  belongs_to :event_hospitality
end
