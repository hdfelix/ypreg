require 'rails_helper'
include Warden::Test::Helpers

module FeatureLoginMacros
	def create_logged_in_admin
		admin = FactoryGirl.create(:user, :with_admin_role)
		admin.confirm!
    admin.current_sign_in_at = Time.now
		admin.save

    login(admin)
    admin
	end

  def login(admin)
		login_as admin, scope: :user
  end
end
