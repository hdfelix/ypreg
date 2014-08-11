class Hospitality < ActiveRecord::Base
  #has_many :registrations, through: :hospitality_assignments
  belongs_to :events
  belongs_to :lodgings
end
