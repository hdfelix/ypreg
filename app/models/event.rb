class Event < ActiveRecord::Base
	validates :title, presence: true	
	validates :begin_date, presence: true
	validates :end_date, presence: true
	validates :registration_cost, presence: true

	EVENT_TYPE = ['One-day','Retreat','Conference']

	belongs_to :location
	accepts_nested_attributes_for :location
end
