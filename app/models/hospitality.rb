class Hospitality < ActiveRecord::Base
  belongs_to :event, inverse_of: :hospitalities
  belongs_to :lodging
  belongs_to :locality # TODO: does his need to be removed? More than one locality can be assigned to an hospitality
  belongs_to :registration
  has_many :registrations, -> { uniq }, through: :hospitality_registration_assignments
  has_many :hospitality_registration_assignments, inverse_of: :hospitality

  delegate :name, :description, :address1, :address2, :city, :state_abbrv,
           :zipcode, :lodging_type, :locality_id, :max_capacity, :min_capacity,
           to: :lodging,
           prefix: true

  delegate :city, :state_abbrv, :contact, :lodging_contact,
           to: :locality,
           prefix: true,
           allow_nil: true

  before_destroy :remove_associations

  private

  def remove_associations
    remove_associated_registrations
    remove_associated_hospitality_registration_assignments
  end

  def remove_associated_registrations
    event.registrations.each do |reg|
      reg.hospitality = nil
    end
  end

  def remove_associated_hospitality_registration_assignments
    hra_array = HospitalityRegistrationAssignment
                .where(event: event, hospitality: self)
    hra_array.each(&:destroy)
  end
end
