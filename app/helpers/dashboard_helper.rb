module DashboardHelper
  def event_widget_header
    content = current_or_future_events_present? ? Event.next.first.title : ''
    content_tag('h5',
                content_tag(:i, '', class: 'fa fa-info-circle') +
                " #{shorten(content, 0, 30, true)}",
                class: 'label label-default')
  end

  def display_event_widget_based_on(role)
    if role == 'admin'
      render template: 'layouts/_event_widget_admin'
    else
      render template: 'layouts/_event_widget'
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
      '0 / 0'
    end
  end

  def data_value_progress_div(chart_values, attribute_name)
    content_tag(:div,
                aria_chart_percentage(chart_values, attribute_name),
                class: 'progress progress-xs')
  end

  def aria_chart_percentage(chart_values, attribute_name)
    content_tag(:div,
                aria_chart_percentage_span,
                bar_chart_attributes(chart_values, attribute_name))
  end

  def aria_chart_percentage_span
    content_tag(:span, '10%', class: 'sr-only')
  end

  def bar_chart_attributes(chart_values, attribute_name)
    prefix = get_hash_id_prefix_from(attribute_name)
    { class: 'progress-bar progress-bar-success',
      role: 'progressbar',
      aria: { valuenow: chart_values["#{prefix}_value_now"],
              valuemin: 0,
              valuemax: chart_values["#{prefix}_value_max"] },
      style: chart_values["#{prefix}_ratio_width_percentage"] }
  end

  def get_hash_id_prefix_from(attribute_name)
    prefix = case attribute_name
             when 'Capacity' then 'cap'
             when 'Localities' then 'loc'
             when 'Hospitality' then 'hosp'
             when 'Payments' then 'pmt'
             end
    prefix
  end
end
