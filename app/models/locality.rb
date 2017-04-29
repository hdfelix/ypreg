# A local church
class Locality < ActiveRecord::Base
  has_many :users
  has_many :lodgings

  has_many :event_localities, dependent: :destroy
  has_many :events, through: :event_localities

  belongs_to :contact, class_name: 'User'
  belongs_to :lodging_contact, class_name: 'User'

  validates :city, presence: true
  validates :state_abbrv, presence: true

  before_save :update_contact_role, if: "contact_id_changed?"

  def self.not_in(localities)
    where.not(id: localities)
  end

  def hospitalities(event)
    Hospitality.where(event: event, locality: self)
  end

  def hospitalities_min(event)
    hosp = hospitalities(event)
    if hosp.empty?
      0
    else
      hosp.map(&:lodging).map(&:min_capacity).sum
    end
  end

  def hospitalities_max(event)
    hosp = hospitalities(event)
    if hosp.empty?
      0
    else
      hosp.map(&:lodging).map(&:max_capacity).sum
    end
  end

  def assigned_beds_total(event)
    hosp = hospitalities(event)
    hosp.map { |h| h.registration_id.nil? ? 0 : 1 }.sum
  end

  def beds_to_assign(event)
    registered_users(event).count - assigned_beds_total(event)
  end

  def registrations(event)
    Registration.locality_roster(self, event)
  end

  def registered_users(event)
    User.joins(:registrations).merge(Registration.locality_roster(self, event))
  end

  def registered_yp(event)
    registered_users(event).reject { |u| u.role != 'yp' }
  end

  def registered_serving_ones(event)
    registrations(event).reject { |r| !r.attend_as_serving_one }
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

  protected
    def update_contact_role
      if contact_id?
        contact.role = 'loc_contact'
        contact.save
      end
    end
end
