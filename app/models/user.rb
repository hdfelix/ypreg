class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :registrations
	has_many :events, through: :registrations
  belongs_to :locality
  belongs_to :hospitality 

#validations 
  USER_ROLE = [['admin',1],
              ['scyp',2],
              ['ycat',3],
              ['loc_contact',4],
              ['hosp_contact',5],
              ['trainee',6],
              ['speaking_brother',7],
              ['supporting_brother',8],
              ['helper',9],
              ['yp',10],
              ['user',11],
              ['guest',12]]


	def role?(base_role)
		role == base_role.to_s
	end
end
