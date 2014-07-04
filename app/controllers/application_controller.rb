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

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :name
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
end
