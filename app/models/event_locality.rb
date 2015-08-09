class EventLocality < ActiveRecord::Base
  self.table_name = 'events_localities'
  belongs_to :event
  belongs_to :locality

	def self.registrations(event, locality)
		Registration.where(event: event, locality: locality)
	end

  def users
    User.where(locality: locality)
  end

	def registrations
		EventLocality.where(event: event, locality: locality)
	end
end
