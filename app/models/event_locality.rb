class EventLocality < ActiveRecord::Base

# == Relationships ========================================================
  belongs_to :event
  belongs_to :locality

  has_many :registrations
  has_many :users, through: :registrations
  has_many :event_lodgings, -> { distinct }, through: :registrations
  has_many :lodgings, -> { distinct }, through: :event_lodgings

# == Scopes ===============================================================
  scope :by_city, -> { joins(:locality).merge(Locality.order(:city)) }

# == Instance Methods =====================================================
  def beds_assigned_to_locality
    tmp = event.beds_assigned_to_locality[locality.city]
    if tmp.nil?
      0
    else
      tmp
    end
  end

  def number_of_beds_assigned_to_registrations
    EventLodging
      .where(event: event, locality: locality)
      .where.not(registration: nil).count
  end
end
