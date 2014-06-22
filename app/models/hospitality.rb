class Hospitality < ActiveRecord::Base
	validates :name, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	validates :state_abbrv, presence: true
	validates :zipcode, presence: true
	validates :hospitality_type, presence: true
	validates :contact_person_id, presence: true
end
