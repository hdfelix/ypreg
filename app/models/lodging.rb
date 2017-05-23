class Lodging < ActiveRecord::Base

# == Constants ============================================================
  enum lodging_type: [:single_room, :cabin, :dorm]

# == Relationships ========================================================
  belongs_to :location
  has_many :event_lodgings

# == Validations ==========================================================
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true

# == Scopes ===============================================================
  scope :by_name, -> { order(:name) }
  scope :at_location, ->(location) { where(location: location) }

end
