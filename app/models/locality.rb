class Locality < ActiveRecord::Base

# == Relationships ========================================================
  has_many :users
  has_many :event_localities, dependent: :destroy

# == Validations ==========================================================
  validates :city, presence: true
  validates :state, presence: true

# == Scopes ===============================================================
  scope :by_city, -> { order(:city) }
  
# == Instance Methods ========================================================
  public

  def event_lodgings(event)
    EventLodging.where(event: event, locality: self)
  end

  def assigned_beds_total(event)
    hosp = event_lodgings(event)
    hosp.map { |h| h.registration_id.nil? ? 0 : 1 }.sum
  end

  def beds_to_assign(event)
    registered_users(event).count - assigned_beds_total(event)
  end

  def registrations(event)
    Registration.where(event: event, locality: self)
  end

  def registered_users(event)
    User.registered_for(event, self)
  end

  def registered_yp(event)
    registered_users(event).reject { |u| u.role != 'yp' }
  end

  def registered_serving_ones(event)
    registrations(event).reject { |r| !r.serving_one }
  end

  def registered_helpers(event)
    registered_users(event).reject { |u| u.role != 'helper' }
  end

  def registered_trainees(event)
    registered_users(event).reject { |u| u.role != 'trainee' }
  end

  def users_not_registered(event)
    users - registered_users(event)
    Registration.locality_roster(self, event)
  end

end
