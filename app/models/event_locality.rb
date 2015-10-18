class EventLocality < ActiveRecord::Base
  self.table_name = 'events_localities'
  belongs_to :event
  belongs_to :locality

	def self.registrations(event, locality)
		Registration.where(event: event, locality: locality)
	end

  def locality_id
    locality.id
  end

  def locality_city
    locality.city
  end

  def users
    User.where(locality: locality)
  end

	def registrations
    Registration.where(event: event, locality: locality)
	end

  def beds_assigned_to_locality
    tmp = event.beds_assigned_to_locality[locality.city]
    if tmp.nil?
      0
    else
      tmp
    end
  end

  def number_of_beds_assigned_to_registrations
    # HospitalityRegistrationAssignment.where(event: event, locality: locality).count
    Hospitality.where(event: event, locality: locality).where.not(registration: nil).count
  end
end
