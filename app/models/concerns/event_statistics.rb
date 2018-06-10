module EventStatistics
  extend ActiveSupport::Concern

  def remaining_spaces
    location.max_capacity - registrations.count
  end

  def participating_localities
    loc_array = []
    if registrations.count > 0
      registrations.each do |registration|
        loc_array << Locality.find(registration.user.locality_id)
      end
    end
    loc_array.uniq
  end

  def registered_saints_from_locality(locality)
    localities.find(locality.id).registrations(self).map(&:user)
  end

  def total_registrations(options = {})
    locality = options[:locality]
    role = options[:role]
    is_serving_one = options[:attend_as_serving_one] ||= false

    if locality.nil? && role.nil?
    end
    # if locality: nil
    if locality.nil? && !role.nil?
      if is_serving_one
        users
          .joins(:registrations)
          .where(role: role, registrations: { attend_as_serving_one: true })
          .uniq
      else
        users.where(role: role).uniq
      end
      # if role.nil
    elsif !locality.nil? && role.nil?
      if is_serving_one
        users
          .joins(:registrations)
          .where(locality: locality, registrations: { attend_as_serving_one: true })
          .uniq
      else
        users.where(locality: locality).uniq
      end
      # if neither locality, role nil
    elsif !locality.nil? && !role.nil? # locality not nil, role not nil, is_serving_one
      if is_serving_one
        tmp =
          users
          .joins(:registrations)
          .where(locality: locality, role: role, registrations: { attend_as_serving_one: true })
          .uniq
        tmp
      else
        users.joins(:registrations).where(locality: locality, role: role).uniq
      end
    else # if both nil
      if is_serving_one
        users
          .joins(:registrations)
          .where(registrations: { attend_as_serving_one: true })
          .uniq
      end
    end
  end

  def registered_serving_ones(locality)
    users
      .joins(:registrations)
      .where(locality: locality, registrations: { attend_as_serving_one: true })
      .uniq
  end

  def conference_guest_count
    registrations.select { |r| r.conference_guest }.count
  end

  def count_present_yp_from(locality)
    registrations.includes(:user).where(locality: locality, status: 'attended')
      .select { |r| r.user.role == 'yp' }.count
  end

  def present_serving_ones_from(locality)
    registrations
      .where(locality: locality, attend_as_serving_one: true, status: 'attended')
  end

  def present_trainees_from(locality)
    users
      .joins(:registrations)
      .where(locality: locality, role: 'trainee', registrations: { status: 'attended' })
  end

  def present_helpers_from(locality)
    users
    .joins(:registrations)
    .where(locality: locality, role: 'helper', registrations: { status: 'attended' })
  end
end
