# Hospitality model - A lodging available for an event
class Hospitality < ActiveRecord::Base
  belongs_to :event, inverse_of: :hospitalities
  belongs_to :lodging
  belongs_to :locality
  has_many :hospitality_registration_assignments, inverse_of: :hospitality
  has_many :registrations, -> { uniq }, through: :hospitality_registration_assignments

  delegate :name, :description, :address1, :address2, :city, :state_abbrv,
    :zipcode, :lodging_type, :locality_id, :max_capacity, :min_capacity,
    to: :lodging
end
