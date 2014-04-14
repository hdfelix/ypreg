class Location < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	#validates :state, presence: true  #How do we validate for states now that they are in a hash variable?
	validates :zipcode, presence: true

	belongs_to :event
end
