class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :set_chart_values

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash.alert = 'You are not allowed to do that!'#exception.message
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    common_params = [:name, :gender, :age, :grade, :locality_id, :email,
                     :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(*common_params)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(*common_params, :role, :home_phone, :cell_phone,
                         :work_phone, :birthday)
    end
  end

  def after_sign_in_path_for(_resource)
    root_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
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
    event_lodging_section_values(next_event, chart_values)
    payments_section_values(next_event, chart_values)
  end

  def non_admin_chart_values(next_event, chart_values)
    locality = current_user.locality
    # Attending
    event_locality = EventLocality.find_by!(event: next_event, locality: locality)
    registration_count = event_locality.registrations.size
    total_users = Locality.find(locality.id).users.size
    chart_values['att_ratio'] = "#{registration_count} / #{total_users}"
    chart_values['att_ratio_width_percentage'] = "width: #{(registration_count.to_f / total_users.to_f) * 100}%"
    chart_values['att_value_now'] = registration_count
    chart_values['att_value_max'] = total_users

    # Event Lodging
    event_lodgings = next_event.event_lodgings
    assigned_event_lodgings_count =
      event_lodgings.assigned.size
    chart_values['hosp_ratio'] = "#{assigned_event_lodgings_count} / #{event_lodgings.size}"
    chart_values['hosp_ratio_width_percentage'] = "width: #{(assigned_event_lodgings_count.to_f / event_lodgings.size.to_f) * 100}%"
    chart_values['hosp_value_now'] = assigned_event_lodgings_count
    chart_values['hosp_value_max'] = event_lodgings.size

    # Paid?
    chart_values['paid?'] = false
  end

  def location_section_values(next_event, chart_values)
    location_capacity = next_event.location.max_capacity
    registration_count = next_event.registrations.size

    chart_values['cap_ratio'] =
      "#{registration_count} / #{location_capacity}"
    chart_values['cap_ratio_width_percentage'] =
      "width: #{((registration_count.to_f / location_capacity.to_f) * 100).to_i}%"
    chart_values['cap_value_now'] = registration_count
    chart_values['cap_value_max'] = location_capacity
  end

  def locality_section_values(next_event, chart_values)
    total_localities = Locality.count
    next_event_localities = next_event.event_localities.size
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
    total_registrations = next_event.registrations.size
    next_event_payments =
      next_event.registrations.paid.size
    chart_values['pmt_ratio'] =
      "#{next_event_payments} / #{total_registrations}"
    chart_values['pmt_ratio_width_percentage'] =
      if total_registrations != 0
        "width: #{((next_event_payments.to_f / total_registrations.to_f) * 100).to_i}%"
      else
        'width: 0'
      end
    chart_values['pmt_value_now'] = next_event_payments
    chart_values['pmt_value_max'] = total_registrations
  end

  def event_lodging_section_values(next_event, chart_values)
    event_event_lodgings_count = next_event.event_lodgings.size
    lodging_count = Lodging.count
    chart_values['hosp_ratio'] =
      "#{event_event_lodgings_count} / #{lodging_count}"
    chart_values['hosp_ratio_width_percentage'] =
      if event_event_lodgings_count != 0
        "width: #{(event_event_lodgings_count.to_f / lodging_count.to_f) * 100}%"
      else
        'width: 0'
      end
    chart_values['hosp_value_now'] = event_event_lodgings_count
    chart_values['hosp_value_max'] = lodging_count
  end
end
