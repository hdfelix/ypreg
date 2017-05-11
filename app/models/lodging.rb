class Lodging < ActiveRecord::Base

# == Constants ============================================================
  enum lodging_type: [:single_room, :cabin, :dorm]

# == Relationships ========================================================
  belongs_to :location
  delegate :name, to: :location, prefix: true

# == Validations ==========================================================
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true

# == Scopes ===============================================================
  scope :at_location, ->(location) { where(location: location) }
  scope :not_assigned_to_event, ->(event) { at_location(event.location).where.not(id: event.event_lodgings) }

end
