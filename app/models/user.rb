# User model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :registrations
  has_many :events, through: :registrations
  has_many :hospitalities, through: :registrations
  belongs_to :locality
  belongs_to :lodging

  # validations

  USER_ROLE = [
    ['admin', 1],
    ['scyp', 2],
    ['ycat', 3],
    ['loc_contact', 4],
    ['hosp_contact', 5],
    ['trainee', 6],
    ['speaking_brother', 7],
    ['supporting_brother', 8],
    ['helper', 9],
    ['yp', 10],
    ['user', 11],
    ['guest', 12]
  ]
  # scopes
  def self.not_contact_persons
    contact_person_ids = Lodging.where.not(contact_person: nil).pluck(:contact_person_id)
    User.where.not(id: contact_person_ids)
  end

   # Interface
  def role?(base_role)
    role == base_role.to_s
  end

  # private?
  def registration(event)
    Registration.where(user: self, event: event)[0]
  end

  # private?
  def hospitality_registration_assignment(event)
    HospitalityRegistrationAssignment.where(registration: registration(event))[0]
  end

  # private?
  def assigned_hospitality(event,locality)
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
