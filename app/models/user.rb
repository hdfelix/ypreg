# User model
class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  include PgSearch
  multisearchable against: [:gender, :role]
  # pg_search_scope :search_by_name, against: :name,
  # using: { tsearch: { dictionary: 'english' } }

  has_many :registrations
  has_many :events, through: :registrations
  has_many :notes, inverse_of: :user
  belongs_to :locality

  validates :locality, presence: true
  validates :gender, presence: true

  # Constants
  GENDER = %w(Brother Sister)
  USER_ROLE = %w(admin scyp ycat loc_contact hosp_contact trainee speaking_brother supporting_brother helper yp guest)
  AGE_MINOR = %w(minor 13 14 15 16 17)
  AGE_ADULT = %w(18 adult)
  AGE = AGE_MINOR + AGE_ADULT
  GRADE = %w(6th 7th 8th 9th 10th 11th 12th college other)

  # scopes
  def self.not_contact_persons
    contact_person_ids =
      Lodging.where.not(contact_person: nil).pluck(:contact_person_id)
    User.where.not(id: contact_person_ids)
  end
  
  def self.minor
    where(age: AGE_MINOR)
  end     

  def self.adult
    where(age: AGE_ADULT)
  end

  def self.background_check_valid
    where("background_check_date >= ?", 36.months.ago.midnight)
  end

  # Interface
  def role?(base_role)
    role == base_role.to_s
  end

  def admin?
    role?(:admin) or role?(:scyp)
  end
 
  def locality_contact?
    role?(:loc_contact)
  end

  def registration(event)
    Registration.where(user: self, event: event)[0]
  end

  def hospitality_registration_assignment(event)
    HospitalityRegistrationAssignment.where(registration: registration(event))[0]
  end

  def assigned_hospitality(event)
    hra = hospitality_registration_assignment(event)
    if hra.nil?
      nil
    else
      hra.hospitality
    end
  end

  def requires_background_check?
    return AGE_ADULT.include?(age)
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
      background_check_date >= 36.months.ago.midnight and background_check_date < 34.months.ago.midnight
    else
      false
    end
  end

  def hospitality(event)
    reg = registration(event)
    if reg.nil?
      nil
    else
      Hospitality.where(event: event, locality: locality)[0]
    end
  end

end
