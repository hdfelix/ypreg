class Hospitality < ActiveRecord::Base
	
	has_and_belongs_to_many :events
	has_one :contact

	validates :name, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	validates :state_abbrv, presence: true
	validates :zipcode, presence: true
	validates :hospitality_type, presence: true
	validates :contact_person_id, presence: true

	HOSPITALITY_TYPE = [['Home',1],['Retreat Center',2],['Hotel/Motel',3]]
	
	def display_address
		if (self.address1 != nil && self.city != nil && self.state_abbrv != nil && self.zipcode != nil)
		"#{self.address1} \n #{self.city}, #{self.state_abbrv}  #{self.zipcode}" 
		else
			"--"
		end
	end

	def display_description
		if self.description == nil
			'--'
		else
			self.description
		end
	end
end
