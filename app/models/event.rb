class Event < ActiveRecord::Base
	belongs_to :location
	has_many	:registrations
	#has_many :users
	has_many :users, through: :registrations

	#skip_before_filter :verify_authenticity_token

	validates :event_type, presence: true
	validates :title, presence: true	
	validates :begin_date, presence: true
	validates :end_date, presence: true
	validates :registration_cost, presence: true
	validates :location_id, presence: true

	EVENT_TYPE = [['One-day',1],['Retreat',2],['Conference',3]]

	default_scope { order('begin_date ASC') }

	def remaining_spaces
		self.location.max_capacity - self.registrations.count
	end

	def participating_localities
		loc_array = []
		self.registrations.all.each do |registration|
			loc_array << Locality.find(registration.user.locality_id)
		end
		loc_array
	end

	def load_locality_summary
		stats = Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = Array.new}}
		Locality.all.each do |locality|
			#Load stats for one locality
			loc = locality.city
			stats[loc]["grand_total"] = self.users.where("locality_id = ?",locality.id).count 
			# Create methods for these values once user types and pmt handling is finalized
			stats[loc]["total_yp"] = [83]
			stats[loc]["total_serving_ones"] = [14]
			stats[loc]["total_trainees"] = [11]
			stats[loc]["total_helpers"] = [8]
			stats[loc]["amount_due"] = stats[loc]["grand_total"] * self.registration_cost
			stats[loc]["actual_grand_total"] = [92]
			stats[loc]["actual_total_yp"] = [56]
			stats[loc]["actual_total_serving_ones"] = [8]
			stats[loc]["actual_total_trainees"] = [6]
			stats[loc]["actual_total_helpers"] = [3]
			stats[loc]["actual_amount_paid"] = 73 * self.registration_cost
			stats[loc]["balance"] = stats[loc]["actual_amount_paid"] - stats[loc]["amount_due"]
		end
		stats
	end
end
