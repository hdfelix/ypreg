class EventLocality < ActiveRecord::Base

# == Relationships ========================================================
  belongs_to :event
  belongs_to :locality

  has_many :registrations
  has_many :users, through: :registrations
  has_many :event_lodgings, -> { distinct }, through: :registrations
  has_many :lodgings, -> { distinct }, through: :event_lodgings

# == Validations ==========================================================
  validates_uniqueness_of :locality, scope: :event

# == Scopes ===============================================================
  scope :by_city, -> { joins(:locality).merge(Locality.order(:city)) }

end
