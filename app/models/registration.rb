class Registration < ActiveRecord::Base
# == Constants ============================================================
  enum payment_type: [:check, :cash]
  enum status: [:attended, :excused]

# == Relationships ========================================================
  belongs_to :event_locality
  has_one :event, through: :event_locality
  has_one :locality, through: :event_locality

  belongs_to :event_lodging
  belongs_to :user

  delegate :name, :email, :background_check_date,
           :cell_phone, :home_phone, :work_phone, :age, :birthday, to: :user

# == Validations ==========================================================
  validates :event_locality, presence: true
  validates :user, presence: true

# == Scopes ===============================================================
  scope :paid, -> { where(paid: true) }
  # TODO: clarify how this differs from guest role
  scope :guest, -> { where(guest: true) }
  scope :serving_one, -> { where(serving_one: true) }
  scope :for_locality, ->(locality) { where(locality: locality) }
  scope :for_role, ->(role) { joins(:user).where(users: {role: role}) }
  scope :by_name, -> { joins(:user).merge(User.order(:name)) }

  # == Callbacks ============================================================

# == Instance Methods =====================================================
  public

  def payment
    if paid
      0
    else
      event.registration_cost - payment_adjustment
    end
  end

end
