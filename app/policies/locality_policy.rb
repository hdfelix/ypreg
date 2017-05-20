class LocalityPolicy < ApplicationPolicy

  def permitted_attributes
    [:city, :state]
  end

  #== Database Ops ==
  def index?
    role?(:admin, :scyp, :locality_contact)
  end

  def show?
    sudo? || (user.locality_contact? && user.locality == record)
  end

  class Scope < Scope
    def resolve
      if sudo?
        scope
      elsif user.locality_contact?
        scope.where(id: user.locality_id)
      end
    end
  end

end
