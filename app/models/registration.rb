# This class represents an user who has registered for an event.
# self.hospitality is the assigned hospitality for the user.

class Registration < ApplicationRecord
  PAYMENT_TYPE = %w(cash check)
  STATUS = %w(attended excused y)

  belongs_to :user
  belongs_to :event
  belongs_to :locality # TODO: should this be removed and a wrapper method registration_locality added?
  belongs_to :hospitality, optional: true
  has_many :hospitality_registration_assignments, inverse_of: :registration

  delegate :name, :email, :cell_phone, :home_phone, :work_phone, :birthday,
           :lodging_id, # ...
           to: :user

  validates :locality, presence: true

  after_create :create_event_locality

  # TODO: pay(amount)
  # TODO paid?

  scope :for_event, ->(event) { where(event: event) }
  scope :all_serving_ones, -> { where(attend_as_serving_one: true) }

  def payment_adjustment
    @payment_adjustment ||= 0
  end

  private

  def create_event_locality
    EventLocality.find_or_create_by(event: event, locality: user.locality)
  end
end
