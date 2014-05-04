class Event < ActiveRecord::Base
	belongs_to :location

	validates :event_type, presence: true
	validates :title, presence: true	
	validates :begin_date, presence: true
	validates :end_date, presence: true
	validates :registration_cost, presence: true
	validates :location_id, presence: true

	EVENT_TYPE = ['One-day','Retreat','Conference']

end
