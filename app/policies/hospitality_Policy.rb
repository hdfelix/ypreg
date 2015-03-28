# Policies for hospitality restful actions
class HospitalityPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || 
                      user.role?(:scyp))
  end

  def show?
    index?
  end
end
