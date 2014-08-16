class Event < ActiveRecord::Base
	belongs_to :location
	has_many	:registrations
	has_many :users, through: :registrations
	has_many :localities, through: :users
  has_many :hospitalities, -> { uniq }
  has_many :lodgings, -> { uniq }, through: :hospitalities
  #has_many :hospitality_assignments

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
		self.registrations.each do |registration|
			loc_array << Locality.find(registration.user.locality_id)
		end
		loc_array
	end

	def load_locality_summary
		stats = Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = Array.new}}
		Locality.all.each do |locality|
			#Load stats for one locality
			loc = locality.city
			stats[loc]['grand_total'] = self.users.where('locality_id = ?',locality.id).count 
			# Create methods for these values once user types and pmt handling is finalized
      stats[loc]['total_yp'] = total_registrations_by_role(locality,'yp')
      stats[loc]['total_serving_ones'] = total_registered_events(locality)
			stats[loc]['total_trainees'] = total_registrations_by_role(locality,'trainee')
			stats[loc]['total_helpers'] = total_registrations_by_role(locality,'helper')
      if stats[loc]['total_serving_ones'] != 0
        stats[loc]['yp_so_ratio'] = stats[loc]['total_yp']/stats[loc]['total_serving_ones']
      else
        stats[loc]['yp_so_ratio'] = '--'
      end
			stats[loc]['amount_due'] = stats[loc]['grand_total'] * self.registration_cost
			stats[loc]['actual_grand_total'] = "[--]"
			stats[loc]['actual_total_yp'] = "[--]"
			stats[loc]['actual_total_serving_ones'] = "[--]"
			stats[loc]['actual_total_trainees'] = "[--]"
			stats[loc]['actual_total_helpers'] = "[--]"
			stats[loc]['actual_amount_paid'] = 73 * self.registration_cost
			stats[loc]['balance'] = stats[loc]['actual_amount_paid'] - stats[loc]['amount_due']
		end
    stats
  end

  def total_registrations_by_role(locality, role)
    self.users.where('locality_id = ? and role = ?', locality.id, role).count
  end

  def total_registered_events(locality)
    self.users.where('locality_id = ? and attend_as_serving_one = ?', locality.id,true).count
  end
end
