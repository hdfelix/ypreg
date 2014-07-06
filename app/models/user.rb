class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :registrations
	has_many :events, through: :registrations

	#validations
	USER_TYPE = [['Serving One',1],['Trainee',2],['YP',3],['Guest',4]]

	def role?(base_role)
		role == base_role.to_s
	end
end
