class Locality < ActiveRecord::Base
	has_and_belongs_to_many :hospitalities

	validates :city, presence: true
	validates :locality_id, presence: true
	validates :state_abbrv, presence: true

	def display_contact
		if self.contact_id == nil
			"--"
		else
			User.find(self.contact_id).name
		end
	end
end
