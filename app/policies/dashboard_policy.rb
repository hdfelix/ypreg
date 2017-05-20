class DashboardPolicy < Struct.new(:user, :dashboard)
  include CommonPolicy
  def show?
    !user.guest?
  end

  def manage_site?
    sudo? || user.locality_contact?
  end
end
