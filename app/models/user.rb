# User model
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :registrations
  has_many :events, through: :registrations
  belongs_to :locality
  belongs_to :lodging

  # validations

  scope :is_not_contact_person, -> { joins('LEFT JOIN lodgings ON lodgings.contact_person_id = users.id WHERE lodgings.id IS NULL') }
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

  # Scopes
  def not_contact_person_drop_down_collection
    User.is_not_contact_person << self
  end

  # Interace
  def role?(base_role)
    role == base_role.to_s
  end
end
