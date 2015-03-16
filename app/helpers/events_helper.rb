module EventsHelper
  def event_location(event)
    location = Location.find(event.location_id)
    html = ''
    content_tag(:address) do
      html <<
        "#{location.address1} \n<br />\n #{location.city},
        #{location.state_abbrv}  #{location.zipcode}"
    end
    html.html_safe
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
        "#{ event.end_date.strftime('%m/%d/%y') } - \
         #{ event.registration_open_date.strftime('%m/%d/%y') }".html_safe
      else
        'TBA'
      end
    end
  end

  def display_event(event)
    if event_type = Event::EVENT_TYPE .detect { |a| a.include?(event.event_type) }
      event_type[0]
    else
      '--'
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
end
