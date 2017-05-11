class User < ActiveRecord::Base
  include PgSearch
  # pg_search_scope :search_by_name, against: :name,
  # using: { tsearch: { dictionary: 'english' } }

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  multisearchable against: [:gender, :role]

# == Constants ============================================================
  ADULT = [:eighteen, :adult]
  enum age: [:minor, :thirteen, :fourteen, :fifteen,
             :sixteen, :seventeen, :eighteen, :adult]
  enum gender: [:brother, :sister]
  enum grade: [:sixth, :seventh, :eighth, :ninth, :tenth,
               :eleventh, :twelfth, :college, :other]
  enum role: [:yp, :trainee, :guest, :helper, :supporting_brother,
              :speaking_brother, :locality_contact, :ycat, :scyp,
              :admin]

# == Relationships ========================================================
  belongs_to :locality
  delegate :city, to: :locality, prefix: true

  has_many :notes
  has_many :registrations
  has_many :events, through: :registrations

# == Validations ==========================================================
  validates :locality, presence: true
  validates :gender, presence: true

# == Scopes ===============================================================
  scope :minor, -> { where.not(age: ADULT) }
  scope :adult, -> { where(age: ADULT) }
  scope :background_check_valid, -> { where("background_check_date >= ?", 36.months.ago.midnight) }
  scope :role_counts, -> { group(:role).size }

# == Instance Methods ========================================================
  def needs_bg_check?
    adult? || eighteen?
  end

  def background_check_valid?
    if background_check_date.present?
      background_check_date >= 36.months.ago.midnight
    else
      false
    end
  end

  def background_check_warning?
    if background_check_date.present?
      background_check_date >= 36.months.ago.midnight && background_check_date < 34.months.ago.midnight
    else
      false
    end
  end

  def registration(event)
    Registration.where(user: self, event: event)[0]
  end

  def event_lodging_registration_assignment(event)
    EventLodgingRegistrationAssignment.where(registration: registration(event))[0]
  end

  def assigned_event_lodging(event)
    hra = event_lodging_registration_assignment(event)
    if hra.nil?
      nil
    else
      hra.event_lodging
    end
  end

  def event_lodging(event)
    reg = registration(event)
    if reg.nil?
      nil
    else
      EventLodging.where(event: event, locality: locality)[0]
    end
  end

end
