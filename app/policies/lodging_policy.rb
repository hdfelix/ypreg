class LodgingPolicy < ApplicationPolicy
  def permitted_attributes
    [:description, :location_id, :lodging_type, :max_capacity, :min_capacity, :name]
  end
end
