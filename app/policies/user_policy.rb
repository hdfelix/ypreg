class UserPolicy < ApplicationPolicy

  def authorized_roles
    if sudo?
      User.roles.keys
    elsif user.locality_contact?
      User.roles.keys - ['admin', 'scyp', 'ycat', 'locality_contact']
    else
      [user.role]
    end
  end
  
  def authorized_role?
    authorized_roles.any? do |authorized_role|
      record.role == authorized_role
    end
  end

  def permitted_attributes
    common_params = [:email, :name, :gender, :age, :grade, :home_phone,
                     :work_phone, :cell_phone, :birthday, :password, :role]
    if sudo?
      common_params + [:locality_id, :background_check_date]
    else
      common_params
    end
  end

  # == Database ops ==
  def index?
    sudo? || user.locality_contact?
  end

  def show?
    if sudo?
      true
    elsif user.locality_contact?
      user.locality == record.locality
    else
      user == record
    end
  end

  def create?
    if sudo?
      true
    elsif user.locality_contact?
      user.locality == record.locality && authorized_role?
    else
      false
    end
  end

  def new?
    sudo? || user.locality_contact?
  end

  def update?
    create? || (user == record && authorized_role?)
  end

  def edit?
    show?
  end

  def destroy?
    create? || user == record
  end

  class Scope < Scope
    def resolve
      if sudo?
        scope
      elsif user.locality_contact?
        locality_users = scope.includes(:locality).where(locality: user.locality)
        locality_users.minor.or(locality_users.adult.background_check_valid)
      end
    end
  end
end
