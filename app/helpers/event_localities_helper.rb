module EventLocalitiesHelper  
  def decorated_user(user)
    # authorize users

    if user.role == 'yp'
      YpUserDecorator.decorate(user)
    else
      UserDecorator.decorate(user)
    end
  end

  def background_check_tr(user, id)
    tag(:tr, { id: id, class: decorated_user(user).background_check_date_row_class })
  end
end
