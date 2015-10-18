# Default application policiy for restful actions
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    fail Pundit::NotAuthorizedError, 'must be logged in' unless user
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    index? # scope.where(id: record.id).exists? && user.role?(:admin)
  end

  def create?
    index?
  end

  def new?
    index?
  end

  def update?
    index?
  end

  def edit?
    index?
  end

  def destroy?
    index?
  end

  def scope
    record.class # Pundit.policy_scope!(user, record.class)
  end
end
