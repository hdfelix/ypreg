# Policies for hospitality restful actions
class HospitalityRegistrationAssignmentPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:scyp))
  end
end
