class UserDecorator < Draper::Decorator
  delegate_all

  def background_check_date_row_class
    date = object.background_check_date
    if date.nil?
      'danger'
    elsif date < 3.years.ago
      'danger'
    elsif date < 34.months.ago
      'warning'
    else
      ''
    end
  end

  def background_check_date_bg_class
    date = object.background_check_date
    if date.nil?
      'bg-danger'
    elsif date < 3.years.ago
      'bg-danger'
    elsif date < 34.months.ago
      'bg-warning'
    else
      ''
    end
  end
end
