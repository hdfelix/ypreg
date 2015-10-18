class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout :layout_by_resource

  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:alert] = exception.message
    redirect_to root_url, alert: exception.message
  end

  before_action :set_chart_values

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :role, :locality_id,
                                                 :gender, :age, :grade]
    devise_parameter_sanitizer.for(:account_update) <<
      [:name, :role, :locality_id, :birthday, :gender, :age, :grade,
       :cell_phone, :home_phone, :work_phone]
  end

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end

  def after_sign_out_path_for(resource)
    request.referer
  end

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def layout_by_resource
    if current_user
      'dashboard'
    else
      'application'
    end
  end

  def set_chart_values
    @chart_values = widget_stats_next_event
  end

  # Dashboard widget helpers
  def widget_stats_next_event
    chart_values = {}

    unless Event.all.count == 0
      next_event = Event.where('begin_date >= ?', Time.zone.now.to_date).first
      get_values_for_aria_chart(next_event, chart_values)
    end
    chart_values
  end

  def get_values_for_aria_chart(next_event, chart_values)
    return if next_event.nil?
    return if current_user.nil?
    if current_user.role == 'admin'
      admin_chart_values(next_event, chart_values)
    else
      non_admin_chart_values(next_event, chart_values)
    end
    chart_values
  end

  def admin_chart_values(next_event, chart_values)
    location_section_values(next_event, chart_values)
    locality_section_values(next_event, chart_values)
    hospitality_section_values(next_event, chart_values)
    payments_section_values(next_event, chart_values)
  end

  def non_admin_chart_values(next_event, chart_values)
    locality = current_user.locality
    # Attending
    registration_count = Registration.where(event: next_event, locality: locality).count
    total_users = Locality.find(locality).users.count
    chart_values['att_ratio'] = "#{registration_count} / #{total_users}"
    chart_values['att_ratio_width_percentage'] = "width: #{(registration_count.to_f / total_users.to_f) * 100}%"
    chart_values['att_value_now'] = registration_count
    chart_values['att_value_max'] = total_users

    # Hospitality
    hospitalities = Hospitality.where(event: next_event, locality: locality)
    assigned_hospitalities_count =
      hospitalities.where.not(registration: nil).count
    chart_values['hosp_ratio'] = "#{assigned_hospitalities_count} / #{hospitalities.count}"
    chart_values['hosp_ratio_width_percentage'] = "width: #{(assigned_hospitalities_count.to_f / hospitalities.count.to_f) * 100}%"
    chart_values['hosp_value_now'] = assigned_hospitalities_count
    chart_values['hosp_value_max'] = hospitalities.count

    # Paid?
    chart_values['paid?'] = false
  end

  def location_section_values(next_event, chart_values)
    location_capacity = next_event.location.max_capacity
    registration_count = next_event.registrations.count

    chart_values['cap_ratio'] =
      "#{registration_count} / #{location_capacity}"
    chart_values['cap_ratio_width_percentage'] =
      "width: #{((registration_count.to_f / location_capacity.to_f) * 100).to_i}%"
    chart_values['cap_value_now'] = registration_count
    chart_values['cap_value_max'] = location_capacity
  end

  def locality_section_values(next_event, chart_values)
    total_localities = Locality.all.count
    next_event_localities = next_event.participating_localities.count
    chart_values['loc_ratio'] = "#{next_event_localities} / #{total_localities}"
    if total_localities != 0
      chart_values['loc_ratio_width_percentage'] =
        "width: #{((next_event_localities.to_f / total_localities.to_f) * 100).to_i}%"
    else
      chart_values['loc_ratio'] = 'width: 0'
    end
    chart_values['loc_value_now'] = next_event_localities
    chart_values['loc_value_max'] = total_localities
  end

  def payments_section_values(next_event, chart_values)
        total_registrations = next_event.registrations.all.count
        next_event_payments =
          next_event.registrations.where(has_been_paid: true).all.count
        chart_values['pmt_ratio'] =
          "#{next_event_payments} / #{total_registrations}"
        if total_registrations != 0
          chart_values['pmt_ratio_width_percentage'] =
            "width: #{((next_event_payments.to_f / total_registrations.to_f) * 100).to_i}%"
        else
          chart_values['pmt_ratio_width_percentage'] = 'width: 0'
        end
        chart_values['pmt_value_now'] = next_event_payments
        chart_values['pmt_value_max'] = total_registrations
  end

  def hospitality_section_values(next_event, chart_values)
    event_hospitalities_count = next_event.hospitalities.count
    lodging_count = Lodging.count
    chart_values['hosp_ratio'] =
      "#{event_hospitalities_count} / #{lodging_count}"
    if event_hospitalities_count != 0
      chart_values['hosp_ratio_width_percentage'] =
        "width: #{(event_hospitalities_count.to_f / lodging_count.to_f) * 100}%"
    else
      chart_values['hosp_ratio_width_percentage'] = 'width: 0'
    end
    chart_values['hosp_value_now'] = event_hospitalities_count
    chart_values['hosp_value_max'] = lodging_count
  end
end
