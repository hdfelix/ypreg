# Policies for payment restful actions
class PaymentPolicy < ApplicationPolicy
  def index?
    user.present? && (user.role?(:admin))
  end
  def show?
    index?
  end
end
