module DashboardHelper
  def event_widget_header

    if current_or_future_events_present?
      content_tag('h5',
                  content_tag(:i,'', class: 'fa fa-info-circle') +
                  " #{shorten(Event.next.first.title, 0, 30, true)}",
                  class: 'label label-default')
    else
      content_tag(:h5, 
                  content_tag(:i,'', class: 'fa fa-info-circle'),
                  class: 'label label-default'
                 )
    end
  end
  def current_or_future_events_present?
    !Event.next.first.nil?
  end

  def event_widget_data_name(name)
    content_tag(:span, name, class: 'data-name')
  end

  def data_value_ratio(chart_values, ratio)
    hash_id = "#{get_hash_id_prefix_from(ratio)}_ratio"
    if current_or_future_events_present?
      "#{chart_values[hash_id]}"
    else
      "0 / 0"
    end
  end

  def data_value_progress_div(chart_values)
    content_tag(:div, aria_chart_percentage(chart_values), class: 'progress progress-xs') 
  end

  def aria_chart_percentage(chart_values)
    content_tag(:div,
                aria_chart_percentage_span,
                bar_chart_attributes(chart_values))
  end

  def aria_chart_percentage_span
    content_tag(:span, '10%', class: 'sr-only')
  end

  def bar_chart_attributes(chart_values)
    { class: 'progress-bar progress-bar-success',
      role: 'progressbar',
      aria: { valuenow: chart_values['att_value_now'],
              valuemin: 0,
              valuemax: chart_values['att_value_max'] },
      style: chart_values['att_ratio_width_percentage'] }
  end

  def get_hash_id_prefix_from(attribute_name)
    prefix = case attribute_name
             when 'Attendance' then 'att'
             end
    prefix
  end
end
