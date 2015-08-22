module DashboardHelper
  def future_events_present?
    Event.count > 0 ? true : false
  end
end
