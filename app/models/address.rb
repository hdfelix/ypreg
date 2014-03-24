class Address < ActiveRecord::Base
	validates :addressline1, presence: true
	validates :city, presence: true
	validates :state_id, presence: true
	validates :zipcode, presence: true
end
