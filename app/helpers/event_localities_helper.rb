module EventLocalitiesHelper
  def decorated_user(user)
    # authorize users

    if user.role == 'yp'
      YpUserDecorator.decorate(user)
    else
      UserDecorator.decorate(user)
    end
  end
end
