class EventLodgingDecorator < ApplicationDecorator
  decorates_association :lodging

  delegate :description, :lodging_type, :location_name, :max_capacity, :min_capacity, :name, to: :lodging

  def lodging_id
    object.lodging.id
  end

end
