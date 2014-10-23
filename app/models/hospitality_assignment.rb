# A hospitality assigment for an event
class HospitalityAssignment < ActiveRecord::Base
  belongs_to :registration
  belongs_to :hospitality
  belongs_to :locality
end
