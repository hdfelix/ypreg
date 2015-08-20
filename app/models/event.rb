# Events model - one-time events, conferences, or retreats
class Event < ActiveRecord::Base
  belongs_to :location
  has_many :registrations
  has_many :users, through: :registrations
  has_many :localities, -> { uniq }, through: :users
  has_many :event_localities
  has_many :hospitalities
  has_many :lodgings, -> { uniq }, through: :hospitalities
  has_many :hospitality_registration_assignments, through: :hospitalities

  # skip_before_filter :verify_authenticity_token

  validates :event_type, presence: true
  validates :title, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true
  validates :registration_cost, presence: true
  validates :location_id, presence: true

  EVENT_TYPE = [['One-day', 1], ['Retreat', 2], ['Conference', 3]]

  default_scope { order('begin_date ASC') }
  scope :current, -> { where('begin_date < ? AND end_date > ?', Time.zone.now.to_date, Time.zone.now.to_date) }
  scope :not_over, -> { where('begin_date >= ? OR end_date > ?', Time.zone.now.to_date, Time.zone.now.to_date) }
  scope :in_the_future, -> { where('begin_date > ?', Time.zone.now.to_date) }
  scope :in_the_past, -> { where('end_date < ?', Time.zone.now.to_date) }
  scope :next, -> { where('begin_date > ?', Time.zone.now.to_date).limit(1)[0] }

  def remaining_spaces
    location.max_capacity - registrations.count
  end

  def participating_localities
    loc_array = []
    if registrations.count > 0
      registrations.each do |registration|
        loc_array << Locality.find(registration.user.locality_id)
      end
    end
    loc_array.uniq
  end

  def registered_saints_from_locality(locality)
      self.localities.find(locality).registrations(self).map(&:user)
  end

  def registered_saints_per_locality
    # TODO: Implement
  end

  def total_registrations(options = {})
    locality = options[:locality]
    role = options[:role]
    is_serving_one = options[:attend_as_serving_one] ||= false

    if locality.nil? && role.nil?
    end
    # if locality: nil
    if locality.nil? && !role.nil?
      if is_serving_one
        users.joins(:registrations)
          .where(role: role, registrations: { attend_as_serving_one: true })
          .uniq
      else
        users.where(role: role).uniq
      end
    # if role.nil
    elsif !locality.nil? && role.nil?
      if is_serving_one
        users.joins(:registrations)
          .where(locality: locality, registrations: { attend_as_serving_one: true })
          .uniq
      else
        users.where(locality: locality).uniq
      end
    # if neither locality, role nil
    elsif !locality.nil? && !role.nil? # locality not nil, role not nil, is_serving_one
      if is_serving_one
        tmp = users.joins(:registrations)
          .where(locality: locality, role: role, registrations: { attend_as_serving_one: true })
          .uniq
        tmp
      else
        users.joins(:registrations).where(locality: locality, role: role).uniq
      end
    else # if both nil
      if is_serving_one
        users.joins(:registrations)
          .where(registrations: { attend_as_serving_one: true })
          .uniq
      end
    end
  end

  def registered_serving_ones(locality)
    users.joins(:registrations)
      .where(locality: locality, registrations: { attend_as_serving_one: true })
      .uniq
      .count
  end

  def calculate_actual_total_yp

  end

  def assigned_lodgings_as_hospitality
    lodging_ids = hospitalities.pluck(:lodging_id)
    lodgings = []
    lodging_ids.each do |lodging_id|
      lodgings << Lodging.find(lodging_id)
    end
    lodgings
  end

  def unassigned_lodgings_as_hospitality
    ids = []
    assigned = assigned_lodgings_as_hospitality
    assigned.each do |hospitality|
      ids << hospitality.id
    end
    Lodging.where.not(id: ids)
  end

  def assigned_hospitality_beds
    hospitalities.inject({}) do |beds_hash, h|
      unless h.locality.nil?
        city = h.locality.city
        beds_hash[city] ||= 0
        beds_hash[city] += h.lodging.min_capacity
      end
      beds_hash
    end
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

  def registration_open?
    Time.zone.now.to_date < registration_close_date
  end

  def over?
    Time.zone.now.to_date > end_date
  end

  protected

  def calculate_locality_statistics(stats, locality)
    loc = locality.city
    # TODO: ambiguous locality_id
    stats[loc]['grand_total'] =
      users.where('users.locality_id = ?', locality.id).count
    assign_totals(stats, locality)
    stats[loc]['amount_due'] =
      stats[loc]['grand_total'] * registration_cost
    assign_grand_totals(stats, locality)
    stats[loc]['balance'] =
      stats[loc]['amount_due'] - stats[loc]['actual_amount_paid']
  end

  def assign_totals(stats, locality)
    loc = locality.city
    stats[loc]['total_yp'] = total_registrations(role: 'yp', locality: locality).count
    stats[loc]['total_serving_ones'] = registered_serving_ones(locality)
    stats[loc]['total_trainees'] =
      total_registrations(role: 'trainee', locality: locality).count
    stats[loc]['total_helpers'] =
      total_registrations(role: 'helper', locality: locality).count
    stats[loc]['yp_so_ratio'] = '--'
    stats[loc]['yp_so_ratio'] =
      stats[loc]['total_yp'] /
      stats[loc]['total_serving_ones'] if stats[loc]['total_serving_ones'] != 0
  end

  def assign_grand_totals(stats, locality)
    loc = locality.city
    stats[loc]['actual_grand_total'] = '[--]'
    stats[loc]['actual_total_yp'] = total_registrations(role: 'yp', locality: locality).map {|u| u if u.registration(self).status = 'attended'}.count
    stats[loc]['actual_total_serving_ones'] = '[--]'
    stats[loc]['actual_total_trainees'] = '[--]'
    stats[loc]['actual_total_helpers'] = '[--]'
    stats[loc]['actual_amount_paid'] = locality_amount_paid(locality)
  end

  def locality_amount_paid(locality)
    registration_cost * Registration.where(event: self, locality: locality, has_been_paid: true).count
  end
end
