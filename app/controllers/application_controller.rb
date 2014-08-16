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

	before_filter :set_chart_values

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :name

		#TODO: Handle all new user params, by action
		if params[:action] == "update" or params[:action] == "new"
			devise_parameter_sanitizer.for(:sign_up) << :role
		end
	end

	def after_sign_in_path_for(resource)
		dashboard_index_path
	end

	def user_not_authorized
		flash[:error] = "You are not authorized to perform this action."
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
		# Values for aria chart
		@chart_values = widget_stats_next_event
	end

	#dashboard widget helpers
	def widget_stats_next_event

		chart_values = {}

		# Values for Attendance aria chart
		if Event.any?
			next_event = Event.where("end_date >= ?", Time.new.to_date).first
			location_capacity = next_event.location.max_capacity 
			registration_count = next_event.registrations.count

			chart_values["att_ratio"] = "#{ registration_count } / #{ location_capacity }"
			chart_values["att_ratio_width_percentage"] = "width: #{( registration_count.to_f / location_capacity.to_f) * 100 }%"
			chart_values["att_value_now"] = registration_count
			chart_values["att_value_max"] = location_capacity

			# Values for Localities aria chart
			total_localities = Locality.all.count
			next_event_localities = Event.where("end_date >= ?", Time.now.to_date).first.participating_localities.count 
      chart_values["loc_ratio"] = "#{ next_event_localities } / #{ total_localities }"
      chart_values["loc_ratio_width_percentage"] = "width: #{ ((next_event_localities.to_f / total_localities.to_f) * 100).to_i }%"
			chart_values["loc_value_now"] = next_event_localities
			chart_values["loc_value_max"] = total_localities

      # Values for Hospitality aria chart
      event_hospitalities_count = next_event.hospitalities.count
      lodging_count = Lodging.count
      chart_values["hosp_ratio"] = "#{ event_hospitalities_count} / #{ lodging_count}"
      chart_values["hosp_ratio_width_percentage"] = "width: #{ (event_hospitalities_count.to_f / lodging_count.to_f) * 100 }%"
      chart_values["hosp_value_now"] = event_hospitalities_count 
      chart_values["hosp_value_max"] = lodging_count
      binding.pry
		end
		chart_values		
	end
end
