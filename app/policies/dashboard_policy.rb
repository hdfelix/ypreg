# Default dashboard policiy for restful actions
class DashboardPolicy
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
    scope.where(id: record.id).exists?
  end

  def create?
    user.present? && (user.role?(:admin))
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.role?(:admin))
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    record.class # Pundit.policy_scope!(user, record.class)
  end
end
