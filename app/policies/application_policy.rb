module CommonPolicy
  def sudo?
    user.admin? || user.scyp?
  end
end

class ApplicationPolicy
  include CommonPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  # == Helpers ==
  def role?(roles)
    roles.any? do |other_role|
      user.role == other_role.to_s
    end
  end

  # == Database Ops ==
  def index?
    sudo?
  end

  def show?
    sudo?
  end

  def create?
    sudo?
  end

  def new?
    create?
  end

  def update?
    sudo?
  end

  def edit?
    update?
  end

  def destroy?
    sudo?
  end

  class Scope
    include CommonPolicy
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user
      @user = user
      @scope = scope
    end

    def resolve
      if sudo?
        scope
      end
    end
  end
end
