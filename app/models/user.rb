class User < ActiveRecord::Base
  # pg_search_scope :search_by_name, against: :name,
  # using: { tsearch: { dictionary: 'english' } }
  #multisearchable against: [:gender, :role]

  #mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


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
  has_many :notes
  has_many :registrations
  has_many :event_localities, through: :registrations
  has_many :events, through: :registrations

# == Validations ==========================================================
  validates :locality, presence: true
  validates :gender, presence: true

# == Scopes ===============================================================
  scope :background_check_valid, -> { where("background_check_date >= ?", 36.months.ago.midnight) }
  scope :role_counts, -> { group(:role).size }
  scope :by_name, -> { order(:name) }

# == Instance Methods ========================================================
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

  def needs_background_check?
    adult? || eighteen?
  end

end
