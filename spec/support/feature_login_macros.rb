require 'rails_helper'

include Warden::Test::Helpers

# Controller login helper

# Features login helper
module FeatureLoginMacros

  # DEPRECATED; update code to use #create_signed_in_user_by_role
	def create_logged_in_admin
		admin = FactoryGirl.create(:user, :with_admin_role)
		admin.confirm!
    admin.current_sign_in_at = Time.now
		admin.save

    login(admin)
    admin
	end

	def create_signed_in_user_by_role(role)
		user = FactoryGirl.create(:user, role: role)
		user.confirm!
    user.current_sign_in_at = Time.now
		user.save

    login(user)
    user
	end
  def login(user)
		login_as user, scope: :user
  end
end
