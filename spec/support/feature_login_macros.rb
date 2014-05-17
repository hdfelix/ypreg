require 'spec_helper'
include Warden::Test::Helpers

module FeatureLoginMacros
	def create_logged_in_user
		user = FactoryGirl.create(:user)
		user.confirm!
		user.save

    login(user)
    user
	end

  def login(user)
		login_as user, scope: :user
  end
end
