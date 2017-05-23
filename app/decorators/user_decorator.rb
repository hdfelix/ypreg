class UserDecorator < ApplicationDecorator
  delegate :email, :locality, :needs_background_check?, :name
  delegate :city, to: :locality, prefix: true

  def self.age_display(age)
    case age
    when 'thirteen' then '13'
    when 'fourteen' then '14'
    when 'fifteen' then '15'
    when 'sixteen' then '16'
    when 'seventeen' then '17'
    when 'eighteen' then '18'
    else age.titleize
    end
  end

  def self.ages
    User.ages.keys.map { |k| [self.age_display(k), k] }
  end

  def self.genders
    User.genders.keys.map { |k| [k.titleize, k] }
  end

  def self.grade_display(grade)
    case grade
    when 'sixth' then '6th'
    when 'seventh' then '7th'
    when 'eighth' then '8th'
    when 'ninth' then '9th'
    when 'tenth' then '10th'
    when 'eleventh' then '11th'
    when 'twelfth' then '12th'
    else grade.titleize
    end
  end

  def self.grades
    User.grades.keys.map { |k| [self.grade_display(k), k] }
  end

  def age
    UserDecorator.age_display(object.age)
  end

  def background_check_date_row_class
    if object.needs_background_check?
      return 'warning' if object.background_check_warning?
      return 'danger' if !object.background_check_valid?
    end
    ''
  end

  def background_check_date
    format_date(object.background_check_date)
  end

  def background_check_date_with_warning
    if object.background_check_valid?
      helpers.content_tag(:span, background_check_date)
    else
      html = helpers.content_tag(:i, '',class: ['fa','fa-exclamation-triangle']) + ' '
      html += content_tag(:span, content_tag(:strong, background_check_date))
      html += tag(:br)
      html += content_tag(:span, "(New Background Check needed to attend any event.)")
      html.html_safe
    end
  end

  def background_check_date_bg_class
    css = background_check_date_row_class
    if not css.blank?
      css = 'bg-' + css
    end
    css
  end

  def birthday
    format_date(object.birthday)
  end

  def cell_phone
    format_phone_number(object.cell_phone)
  end

  def first_name
    object.name.split(/\W+/)[0]
  end

  def gender
    object.gender.titleize
  end

  def grade
    UserDecorator.grade_display(object.grade)
  end

  def home_phone
    format_phone_number(object.home_phone)
  end

  def last_sign_in_at
    format_date(object.last_sign_in_at)
  end

  def phone_numbers
    "C: #{cell_phone} H: #{home_phone} W: #{work_phone}"
  end

  def role
    return '' if object.role.nil?
    case object.role
    when 'scyp' then 'SCYP'
    when 'ycat' then 'YCAT'
    when 'yp' then 'YP'
    else object.role.titleize
    end
  end

  def work_phone
    format_phone_number(object.work_phone)
  end
end
