module DashboardHelper
  def user_can_manage_site(user)
    %w(admin scyp ycat loc_contact).include?(user.role)
  end

  # Event widget helpers
  def event_widget_header
    content = current_or_future_events_present? ? Event.next.first.title : ''
    content_tag(
      'h5',
      content_tag(:i, '', class: 'fa fa-info-circle') +
      " #{shorten(content, 0, 30, true)}",
      class: 'label label-default'
    )
  end

  def display_event_widget_based_on(role)
    return if role == 'yp'
    render partial: 'layouts/event_widget', locals: { role: role }
  end

  def display_global_stats_widget_based_on(role)
    return if !role == 'admin'
    render partial: 'layouts/global_stats_widget',
           locals: { current_user: current_user }
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
    content_tag(
      :div,
      aria_chart_percentage(chart_values, attribute_name),
      class: 'progress progress-xs'
    )
  end

  def aria_chart_percentage(chart_values, attribute_name)
    content_tag(
      :div,
      aria_chart_percentage_span,
      bar_chart_attributes(chart_values, attribute_name)
    )
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
    prefix =
      case attribute_name
      when 'Capacity' then 'cap'
      when 'Localities' then 'loc'
      when 'Hospitality' then 'hosp'
      when 'Payments' then 'pmt'
      when 'Attending' then 'att'
      end
    prefix
  end
end
