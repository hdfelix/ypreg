# Hospitality model - A lodging available for an event
class Hospitality < ActiveRecord::Base
  belongs_to :event
  belongs_to :lodging
  belongs_to :locality # think about this more...
  # has_one :location   # thinks bout this more...
  has_many :hospitality_assignments
  has_many :registrations, -> { uniq }, through: :hospitality_assignments

  delegate :name, :description, :address1, :address2, :city, :state_abbrv,
    :zipcode, :lodging_type, :locality_id, :max_capacity, :min_capacity,
    to: :lodging

  def lodging
    Lodging.find(lodging_id)
  end

  def hosted_locality
    Locality.find(locality_id)
  end
end
