# Policies for Hospitality Assigment restful actions
class HospitalityAssignmentPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:hosp_contact))
  end
end
