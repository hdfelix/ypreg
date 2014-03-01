class Location < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
	validates :address_id, presence: true, uniqueness: true
end
