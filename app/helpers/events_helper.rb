module EventsHelper

  def event_button_text_based_on_user_role
    current_user.speaking_brother? ? 'View' : 'Manage'
  end

  def event_dates(event)
    content_tag(:span) do
      if event.begin_date && event.end_date
        "#{event.begin_date.strftime('%m/%d/%y')} - \
        #{event.end_date.strftime('%m/%d/%y')}".html_safe
      else
        'TBA'
      end
    end
  end

  def event_registration_dates(event)
    content_tag(:span) do
      if event.registration_open_date && event.registration_close_date
        "#{ event.registration_open_date.strftime('%m/%d/%y') } - \
         #{ event.registration_close_date.strftime('%m/%d/%y') }".html_safe
      else
        'TBA'
      end
    end
  end

  def display_max_cap(location)
    if location.max_capacity.nil?
      content_tag :span, class: 'text-danger' do
        'None Specified'
      end
    else
      content_tag(:span) do
        "#{location.max_capacity} saints"
      end
    end
  end

  def style_balance(balance)
    if balance > 0
      content_tag('span',number_to_currency(balance), class: 'negative').html_safe
    else
      content_tag('span',number_to_currency(balance)).html_safe
    end
  end

  def show_attendance_menu_option?(event)
    Event.current.map(&:id).include?(event.id)
  end

end
