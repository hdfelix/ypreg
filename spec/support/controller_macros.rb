module ControllerMacros

  def sign_in_user(user = double('user'))
    if user.nil?
      allow(request.env['warden']).
        to receive(:authenticate!).and_throw(:warden, scope: :user)
      allow(controller).
        to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).
        to receive(:authenticate!).and_return(user)
      allow(controller).
        to receive(:current_user).and_return(user)
    end
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in user
    user
  end
end
