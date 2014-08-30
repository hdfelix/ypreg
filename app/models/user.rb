# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  locality_id            :integer
#  home_phone             :decimal(, )
#  cell_phone             :decimal(, )
#  work_phone             :decimal(, )
#  birthday               :date
#  lodging_id             :integer
#

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

  scope :is_not_contact_person, -> { where('lodging_id is null') }
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

  def role?(base_role)
    role == base_role.to_s
  end
end
