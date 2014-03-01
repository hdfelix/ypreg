class Event < ActiveRecord::Base
	validates :title, presence: true	
	validates :begin_date, presence: true
	validates :end_date, presence: true
	validates :registration_cost, presence: true
end
