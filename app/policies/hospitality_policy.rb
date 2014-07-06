class HospitalityPolicy < ApplicationPolicy
	def index?
		user.present? && (user.role?(:admin))
	end
end
