class Registration < ActiveRecord::Base
# == Constants ============================================================
  enum payment_type: [:check, :cash]
  enum status: [:attended, :excused]

# == Relationships ========================================================
  belongs_to :event_locality
  has_one :event, through: :event_locality
  has_one :locality, through: :event_locality

  belongs_to :event_lodging
  has_one :lodging, through: :event_lodging

  belongs_to :user

# == Validations ==========================================================
  validates :event_locality, presence: true
  validates :user, presence: true
  validates_uniqueness_of :user, scope: :event_locality
  validate :lodging_vacancy?

  def lodging_vacancy?
    if event_lodging_id? && event_lodging.registrations.count < lodging.max_capacity
      errors.add(:event_lodging, 'is full')
    end
  end

# == Scopes ===============================================================
  scope :paid, -> { where(paid: true) }
  # TODO: clarify how this differs from guest role
  scope :guest, -> { where(guest: true) }
  scope :serving_one, -> { where(serving_one: true) }
  scope :by_user_name, -> { joins(:user).merge(User.order(:name)) }
  scope :by_event_locality, -> { group(:event_locality) }
  scope :event_locality_counts, -> { by_event_locality.size }

# == Instance Methods =====================================================

end
