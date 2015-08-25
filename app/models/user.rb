# User model
class User < ActiveRecord::Base
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
  belongs_to :locality

  validates :locality, presence: true
  validates :gender, presence: true

  # Constants
  GENDER = %w(Brother Sister)
  USER_ROLE = %w(admin scyp ycat loc_contact hosp_contact trainee speaking_brother supporting_brother helper yp user guest)
  AGE = %w(minor 13 14 15 16 17 18 adult)
  GRADE = %w(6th 7th 8th 9th 10th 11th 12th College other)

  # scopes
  def self.not_contact_persons
    contact_person_ids = Lodging.where.not(contact_person: nil).pluck(:contact_person_id)
    User.where.not(id: contact_person_ids)
  end

   # Interface
  def role?(base_role)
    role == base_role.to_s
  end

  def locality_city
    if locality.nil?
      ""
    else
      locality.city
    end
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

  # private?
  def hospitality(event)
    reg = registration(event)
    if reg.nil?
      nil
    else
      Hospitality.where(event: event, locality: locality)[0]
    end
  end
end
