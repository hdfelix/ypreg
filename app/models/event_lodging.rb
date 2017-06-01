class EventLodging < ActiveRecord::Base

# == Relationships ========================================================
  belongs_to :event
  belongs_to :lodging
  has_many :registrations, dependent: :nullify
  
# == Validations ==========================================================
  validates_uniqueness_of :lodging, scope: :event

# == Scopes ===============================================================
  #scope :assigned, -> { joins(:registrations).distinct }
  scope :by_name, -> { joins(:lodging).merge(Lodging.order(:name)) }
  scope :with_vacancy, -> { joins(:lodging).left_outer_joins(:registrations).group(:id).having('COUNT(registrations.id) < MAX(lodgings.max_capacity)') }

end
