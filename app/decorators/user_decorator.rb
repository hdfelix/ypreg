class UserDecorator < Draper::Decorator
  delegate_all

  def background_check_date_row_class
    date = object.background_check_date
    css = case
          when date.nil? then 'danger'
          when date < 3.years.ago then 'danger'
          when date < 34.months.ago then 'warning'
          else ''
          end
    css
  end

  def background_check_date_bg_class
    date = object.background_check_date
    css = case
          when date.nil? then 'bg-danger'
          when date < 3.years.ago then 'bg-danger'
          when date < 34.months.ago then 'bg-warning'
          else ''
          end
    css
  end
end
