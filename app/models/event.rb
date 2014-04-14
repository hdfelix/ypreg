class Event < ActiveRecord::Base
	validates :title, presence: true	
	validates :begin_date, presence: true
	validates :end_date, presence: true
	validates :registration_cost, presence: true

	EVENT_TYPE = ['One-day','Retreat','Conference']
	
	has_many :locations
	accepts_nested_attributes_for :locations
end
