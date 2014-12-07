# Hospitality model - A lodging available for an event
class Hospitality < ActiveRecord::Base
  belongs_to :event, inverse_of: :hospitalities
  belongs_to :lodging
  belongs_to :locality # think about this more...
  has_many :hospitality_assignments, inverse_of: :hospitality
  has_many :registrations, -> { uniq }, through: :hospitality_assignments

  delegate :name, :description, :address1, :address2, :city, :state_abbrv,
    :zipcode, :lodging_type, :locality_id, :max_capacity, :min_capacity,
    to: :lodging

  def lodging
    Lodging.find(lodging_id)
  end

  def hosted_locality
    # TODO: Why does type casting change the ID???
    # Locality.find(locality_id)
    Locality.find(locality_id_before_type_cast)
  end
end
