class EventLodging < ActiveRecord::Base

# == Relationships ========================================================
  belongs_to :event
  belongs_to :lodging
  has_many :registrations, dependent: :nullify

  delegate :description, :lodging_type, :max_capacity, :min_capacity, :name, to: :lodging

# == Scopes ===============================================================
  scope :assigned, -> { joins(:registrations).distinct }

# == Callbacks ============================================================

# == Instance Methods =====================================================

end
