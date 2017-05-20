class EventLocalityPolicy < ApplicationPolicy

  def index?
    sudo? or user.locality_contact?
  end

  def show?
    sudo? or (user.locality_contact? && user.locality == record.locality)
  end

  def create?
    sudo? or (user.locality_contact? && user.locality = record.locality)
  end

  class Scope < Scope
    def resolve
      if sudo?
        scope
      elsif user.locality_contact?
        scope.where(locality: user.locality)
      end
    end
  end
end
