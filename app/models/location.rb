class Location < ActiveRecord::Base

# == Constants ============================================================
  enum location_type: [:camp, :meeting_hall]

# == Relationships ========================================================
  has_many :events
  has_many :lodgings, dependent: :destroy

# == Validations ==========================================================
  validates :city, presence: true
  validates :name, presence: true

# == Scopes ===============================================================
  scope :by_name, -> { order(:name) }

end
