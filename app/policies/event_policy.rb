# Policies for event restful actions
class EventPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin) || user.role?(:scyp) || user.role?(:hosp_contact))
  end
  def show?
    user.present? && (user.role?(:admin) || user.role?(:scyp) || user.role?(:hosp_contact))
  end
  def new?
    user.present? && (user.role?(:admin))
  end
end
