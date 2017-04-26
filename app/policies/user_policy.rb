# Policies for user restful actions
class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope.includes(:locality)
      elsif user.locality_contact?
        locality = scope.includes(:locality).where(locality: user.locality)
        locality.minor.or(locality.adult.background_check_valid)
      end
    end
  end

  def authorized_roles
    if user.admin?
      User::USER_ROLE
    elsif user.locality_contact?
      User::USER_ROLE - %w(admin scyp ycat loc_contact hosp_contact)
    else
      [user.role]
    end
  end
  
  def authorized_role?
    authorized_roles.include?(record.role)
  end

  def role_edit?
    user.admin? or user.locality_contact?
  end

  def index?
    user.admin? or user.locality_contact?
  end

  def show?
    if user.admin?
      true
    elsif user == record
      true
    elsif user.locality_contact?
      user.locality == record.locality
    else
      false
    end
  end

  def create?
    if user.admin?
      true
    elsif user.locality_contact?
      user.locality == record.locality and authorized_role?
    else
      false
    end
  end

  def new?
    user.admin? or user.locality_contact?
  end

  def update?
    create? or (user == record and authorized_role?)
  end

  def edit?
    show?
  end

  def destroy?
    create? or user == record
  end
end
