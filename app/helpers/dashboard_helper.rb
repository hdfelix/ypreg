module DashboardHelper
  def current_or_future_events_present?
    !Event.next.first.nil?
  end
end
