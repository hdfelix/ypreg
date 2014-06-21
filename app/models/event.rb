class Event < ActiveRecord::Base
	belongs_to :location
	has_many	:registrations
	has_many :users
	has_many :events, through: :registrations

	#skip_before_filter :verify_authenticity_token

	validates :event_type, presence: true
	validates :title, presence: true	
	validates :begin_date, presence: true
	validates :end_date, presence: true
	validates :registration_cost, presence: true
	validates :location_id, presence: true

	EVENT_TYPE = [['One-day',1],['Retreat',2],['Conference',3]]

	default_scope { order('begin_date ASC') }

end
