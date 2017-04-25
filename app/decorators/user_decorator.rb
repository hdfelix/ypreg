class UserDecorator < Draper::Decorator
  delegate_all

  def background_check_date_row_class
    if object.background_check_valid?
      return ''
    end
    date = object.background_check_date
    case
      when date.nil? then 'danger'
      when date < 3.years.ago then 'danger'
      when date < 34.months.ago then 'warning'
      else ''
    end
  end

  def background_check_date_bg_class
    css = background_check_date_row_class
    if not css.empty?
      css = 'bg-' + css
    end
    css
  end

  def locality_city
    if locality.nil?
      ''
    else
      locality.city
    end
  end
end
