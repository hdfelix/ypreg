module EventStatistics
  extend ActiveSupport::Concern

  included do
    def remaining_spaces
      location.max_capacity - registrations.count
    end

    def participating_localities
      loc_array = []
      if registrations.count.positive?
        registrations.each do |registration|
          loc_array << Locality.find(registration.user.locality_id)
        end
      end
      loc_array.uniq
    end

    def registered_saints_from_locality(locality)
      localities.find(locality.id).registrations(self).map(&:user)
    end

    def registered_serving_ones(locality)
      users.joins(:registrations).from_locality(locality).merge(Registration.all_serving_ones).uniq
    end

    def conference_guest_count
      registrations.select(&:conference_guest).count
    end

    def count_present_yp_from(locality)
      registrations
        .includes(:user).where(locality: locality, status: 'attended')
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

    def total_registrations(options = {})
      locality = options[:locality]
      role = options[:role]
      is_serving_one = options[:attend_as_serving_one] ||= false

      if locality.nil? && role.nil?
        users.joins(:registrations).merge(Registration.all_serving_ones).uniq if is_serving_one
      elsif locality.nil? && role.present?
        users_with_role(role).merge(Registration.all_serving_ones).uniq if is_serving_one
        users_with_role(role).uniq
      elsif locality.present? && role.nil?
        users_from_locality(locality).merge(Registration.all_serving_ones).uniq if is_serving_one
        users.from_locality(locality).uniq
      elsif locality.present? && role.present?
        if is_serving_one
          users
            .joins(:registrations)
            .where(locality: locality, role: role, registrations: { attend_as_serving_one: true })
            .uniq
        else
          users.joins(:registrations).where(locality: locality, role: role).uniq
        end
      end
    end
  end

  private

  def users_with_role(role)
    users.joins(:registrations).with_role(role)
  end

  def users_from_locality(locality)
    users.joins(:registrations).from_locality(locality)
  end

  def serving_ones
    merge(Registration.all_serving_ones)
  end
end
