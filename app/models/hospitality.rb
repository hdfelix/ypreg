class Hospitality < ActiveRecord::Base
  belongs_to :event, inverse_of: :hospitalities
  belongs_to :lodging
  belongs_to :locality
  belongs_to :registration
  has_many :registrations, -> { uniq }, through: :hospitality_registration_assignments
  has_many :hospitality_registration_assignments, inverse_of: :hospitality

  delegate :name, :description, :address1, :address2, :city, :state_abbrv,
           :zipcode, :lodging_type, :locality_id, :max_capacity, :min_capacity,
           to: :lodging,
           prefix: :lodging

  delegate :city, :state_abbrv, :contact, :lodging_contact,
           to: :locality,
           prefix: :locality,
           allow_nil: true
end
