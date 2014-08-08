class LocationPolicy < ApplicationPolicy
	def index?
		user.present? && (user.role?(:admin))
	end

  def show?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
