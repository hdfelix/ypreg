# Hospitality model - A lodging available for an event
class Hospitality < ActiveRecord::Base
  belongs_to :events
  belongs_to :lodgings
  has_many :hospitality_assignments
  has_many :registrations, -> { uniq }, through: :hospitality_assignments

  def lodging
    Lodging.find(lodging_id)
  end
end
