# Events model - one-time events, conferences, or retreats
class Event < ActiveRecord::Base
  belongs_to :location
  has_many :registrations
  has_many :users, through: :registrations
  has_many :localities, -> { uniq }, through: :users
  has_many :hospitalities, -> { uniq }
  has_many :lodgings, -> { uniq }, through: :hospitalities
  has_many :hospitality_assignments, through: :hospitalities

  # skip_before_filter :verify_authenticity_token

  validates :event_type, presence: true
  validates :title, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true
  validates :registration_cost, presence: true
  validates :location_id, presence: true

  EVENT_TYPE = [['One-day', 1], ['Retreat', 2], ['Conference', 3]]

  default_scope { order('begin_date ASC') }

  def remaining_spaces
    location.max_capacity - registrations.count
  end

  def participating_localities
    loc_array = []
    registrations.each do |registration|
      loc_array << Locality.find(registration.user.locality_id)
    end
    loc_array.uniq
  end

  def load_locality_summary
    stats = Hash.new do
      |hash, key| hash[key] = Hash.new { |h, k| h[k] = Array.new }
    end

    localities.uniq.each do |locality|
      calculate_locality_statistics(stats, locality)
    end
    stats
  end

  def calculate_locality_statistics(stats, locality)
    loc = locality.city
    stats[loc]['grand_total'] =
      users.where('locality_id = ?', locality.id).count
    assign_totals(stats, locality)
    stats[loc]['amount_due'] =
      stats[loc]['grand_total'] * registration_cost
    assign_grand_totals(stats, locality)
    stats[loc]['balance'] =
      stats[loc]['actual_amount_paid'] - stats[loc]['amount_due']
  end

  def assign_totals(stats, locality)
    loc = locality.city
    stats[loc]['total_yp'] = total_registrations_by_role(locality, 'yp')
    stats[loc]['total_serving_ones'] = total_registered_events(locality)
    stats[loc]['total_trainees'] =
      total_registrations_by_role(locality, 'trainee')
    stats[loc]['total_helpers'] =
      total_registrations_by_role(locality, 'helper')
    stats[loc]['yp_so_ratio'] = '--'
    stats[loc]['yp_so_ratio'] =
      stats[loc]['total_yp'] /
      stats[loc]['total_serving_ones'] if stats[loc]['total_serving_ones'] != 0
  end

  def assign_grand_totals(stats, locality)
    loc = locality.city
    stats[loc]['actual_grand_total'] = '[--]'
    stats[loc]['actual_total_yp'] = '[--]'
    stats[loc]['actual_total_serving_ones'] = '[--]'
    stats[loc]['actual_total_trainees'] = '[--]'
    stats[loc]['actual_total_helpers'] = '[--]'
    stats[loc]['actual_amount_paid'] = 73 * registration_cost
  end

  def total_registrations_by_role(locality, role)
    users.where('locality_id = ? and role = ?', locality.id, role).count
  end

  def total_registered_events(locality)
    users.where(
      'locality_id = ? and attend_as_serving_one = ?',
      locality.id, true).count
  end

  def assigned_hospitalities
    lodging_ids = self.hospitalities.pluck(:lodging_id)
    lodgings = []
    lodging_ids.each do |lodging_id|
      lodgings << Lodging.find(lodging_id)
    end
    lodgings
  end

  def unassigned_hospitalities
    ids = [] 
    assigned = self.assigned_hospitalities
    assigned.each do |hospitality|
      ids << hospitality.id
    end
    Lodging.where.not(id: ids).first
  end
end
