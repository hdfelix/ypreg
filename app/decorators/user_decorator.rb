class UserDecorator < Draper::Decorator
  delegate_all

  def background_check_date_row_class
    return '' if !object.needs_bg_check?
    return 'warning' if object.background_check_warning?
    return 'danger' if !object.background_check_valid?
    ''
  end

  def background_check_date_bg_class
    css = background_check_date_row_class
    if not css.blank?
      css = 'bg-' + css
    end
    css
  end
end
