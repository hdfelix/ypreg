class EventHospitality < ActiveRecord::Base
  #has_many :registrations, through: :hospitality_assignments
  belongs_to :events
  belongs_to :hospitalities
end
