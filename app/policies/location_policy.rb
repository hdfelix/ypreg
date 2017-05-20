class LocationPolicy < ApplicationPolicy
  def permitted_attributes
    [:address1, :address2, :city, :description, :location_type, :max_capacity,
     :name, :state, :zipcode]
  end 
end
