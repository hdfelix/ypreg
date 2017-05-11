class DashboardPolicy < Struct.new(:user, :dashboard)
  def show?
    !user.guest?
  end

  def manage_site?
    user.admin? || user.scyp? || user.locality_contact?
  end
end
