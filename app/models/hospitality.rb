# Hospitality model - A lodging available for an event
class Hospitality < ActiveRecord::Base
  belongs_to :events
  belongs_to :lodgings
  has_many :hospitality_assignments
  has_many :registrations, -> { uniq }, through: :hospitality_assignments

  delegate :name, :description, :address1, :address2, :city, :state_abbrv,
           :zipcode, :lodging_type, :locality_id, :max_capacity, :min_capacity,
           to: :lodging

  def lodging
    Lodging.find(lodging_id)
  end
end
