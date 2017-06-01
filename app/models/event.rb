class Event < ActiveRecord::Base

# == Constants ============================================================
  enum event_type: ["Conference", "Retreat", "One-day"]

# == Relationships ========================================================
  belongs_to :location
  has_many :location_lodgings, through: :location, source: :lodgings

  has_many :event_localities, dependent: :destroy
  has_many :localities, through: :event_localities

  has_many :registrations, through: :event_localities
  has_many :users, through: :registrations

  has_many :event_lodgings, dependent: :destroy
  has_many :lodgings, through: :event_lodgings
  has_many :available_lodgings, -> { with_vacancy }, class_name: 'EventLodging'

# == Validations ==========================================================
  validate :dates_make_sense?
  validates :begin_date, presence: true
  validates :end_date, presence: true
  validates :event_type, presence: true
  validates :name, presence: true
  validates :registration_open_date, presence: true
  validates :registration_close_date, presence: true
 
  def dates_make_sense?
    return if begin_date.nil? || end_date.nil?
    if begin_date >= end_date
      errors.add(:begin_date, "must be before the end date")
    end
    return if registration_open_date.nil? || registration_close_date.nil?
    if registration_open_date >= registration_close_date
      errors.add(:registration_open_date, "must be before the registration close date")
    end
  end

# == Scopes ===============================================================
  scope :by_begin_date, -> { order(:begin_date) }
  scope :in_the_future, -> { where('begin_date > ?', Time.zone.now.to_date) }
  scope :in_the_past, -> { where('end_date < ?', Time.zone.now.to_date) }
  scope :next, -> { current.or(Event.in_the_future).first }

  def self.current
    now = Time.zone.now.to_date
    where('begin_date <= ? AND end_date >= ?', now, now)
  end

  def self.not_over
    now = Time.zone.now.to_date
    where('begin_date >= ? OR end_date > ?', now, now)
  end

# == Instance Methods =====================================================
  def current?
    now = Time.zone.now.to_date
    begin_date <= now && end_date >= now
  end

  def over?
    end_date < Time.zone.now.to_date
  end

  def registration_open?
    today = Time.zone.now.to_date
    today >= registration_open_date && today <= registration_close_date
  end

  def registered_saints_from_locality(locality)
    localities.find(locality).registrations(self).map(&:user)
  end

  def total_registrations(options = {})
    locality = options[:locality]
    role = options[:role]
    is_serving_one = options[:serving_one] ||= false

    if locality.nil? && role.nil?
    end
    # if locality: nil
    if locality.nil? && !role.nil?
      if is_serving_one
        users.joins(:registrations)
          .where(role: role, registrations: { serving_one: true })
          .uniq
      else
        users.where(role: role).uniq
      end
    # if role.nil
    elsif !locality.nil? && role.nil?
      if is_serving_one
        users
          .joins(:registrations)
          .where(locality: locality,
                registrations: { serving_one: true })
          .uniq
      else
        users.where(locality: locality).uniq
      end
    # if neither locality, role nil
    elsif !locality.nil? && !role.nil? # locality not nil, role not nil, is_serving_one
      if is_serving_one
        tmp = users
          .joins(:registrations)
          .where(locality: locality,
                 role: role, registrations: { serving_one: true })
          .uniq
        tmp
      else
        users.joins(:registrations).where(locality: locality, role: role).uniq
      end
    else # if both nil
      if is_serving_one
        users.joins(:registrations)
          .where(registrations: { serving_one: true })
          .uniq
      end
    end
  end

  def registered_serving_ones(locality)
    users.joins(:registrations)
      .where(locality: locality, registrations: { serving_one: true })
      .uniq
  end

  def conference_guests_from(locality)
      registrations.includes(:user).guest.for_locality(locality)
  end

  def conference_guest_count
    registrations.select { |r| r.guest }.count
  end

  def count_present_yp_from(locality)
    registrations.includes(:user).where(locality: locality, status: 'attended')
      .select { |r| r.user.role == 'yp' }.count
  end

  def present_serving_ones_from(locality)
    registrations
      .where(locality: locality, serving_one: true, status: 'attended')
  end

  def present_trainees_from(locality)
    users
      .joins(:registrations)
      .where(locality: locality,
             role: 'trainee', registrations: { status: 'attended' })
  end

  def present_helpers_from(locality)
    users.
      joins(:registrations)
      .where(locality: locality,
             role: 'helper', registrations: { status: 'attended' })
  end

  def calculate_actual_total_yp
    total_registrations(role: 'yp', locality: locality)
      .map { |u| u if u.registration(self).status = 'attended' }.count
  end

  def beds_assigned_to_locality
    event_lodgings.inject({}) do |beds_hash, h|
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
      |hash, key| hash[key] = Hash.new { |h, k| h[k] = [] }
    end

    event_localities.each do |event_locality|
      calculate_event_locality_statistics(stats, event_locality)
    end
    stats
  end


  def payment_adjustments(locality)
    registrations.where(locality: locality)
      .pluck(:payment_adjustment)
      .reject { |p| p.nil? }
      .inject(0) { |sum, r| sum + r }
  end

  def payments
    registrations.where(paid: true).count
  end

  def attendance
    registrations.where(status: 'attended').count
  end

  def medical_release_forms_returned
    registrations.where(medical_release: true).count
  end

  def copy
    copied_event = dup
    copied_event.name = name + ' (copy)'
    copied_event.save
    event_lodgings.map(&:lodging).each do |lodging|
      copied_event.event_lodgings <<
        EventLodging.create(event: copied_event, lodging: lodging)
    end
    copied_event.save
    copied_event
  end

  private

  def calculate_event_locality_statistics(stats, event_locality)
    stats[event_locality]['guests'] = loc.registrations.guest.size
    stats[loc]['grand_total'] = loc.registrations.size
    assign_totals(stats, locality)
    stats[loc]['amount_due'] =
      (stats[loc]['grand_total'] * registration_cost) - payment_adjustments(locality)
    assign_grand_totals(stats, locality)
    stats[loc]['balance'] =
      stats[loc]['amount_due'] - stats[loc]['actual_amount_paid']
  end

  def assign_totals(stats, locality)
    loc = locality.city
    stats[loc]['total_yp'] = total_registrations(role: 'yp', locality: locality).count
    stats[loc]['total_serving_ones'] = registered_serving_ones(locality).count
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
    actual_yp_count = count_present_yp_from(locality)
    actual_serving_ones_count = present_serving_ones_from(locality).count
    actual_trainees_count = present_trainees_from(locality).count
    actual_helpers_count = present_helpers_from(locality).count
    actual_total = Registration.where(event: self, locality: locality, status: 'attended').count

    stats[loc]['actual_grand_total'] = actual_total
    stats[loc]['actual_total_yp'] = actual_yp_count
    stats[loc]['actual_total_serving_ones'] = actual_serving_ones_count
    stats[loc]['actual_total_trainees'] = actual_trainees_count
    stats[loc]['actual_total_helpers'] = actual_helpers_count
    stats[loc]['actual_amount_paid'] = locality_amount_paid(locality)
  end

  def locality_amount_paid(locality)
    paid_registrations =
      Registration.where(event: self, locality: locality, paid: true)

    amount_paid = 0
    paid_registrations.each { |pr| amount_paid += registration_cost - pr.payment_adjustment if pr.paid }
    amount_paid
  end
end
