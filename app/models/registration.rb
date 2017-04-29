# This class represents an user who has registered for an event.
# self.hospitality is the assigned hospitality for the user.
class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :locality # TODO: should this be removed and a wrapper method registration_locality added?
  belongs_to :hospitality
  has_many :hospitality_registration_assignments, inverse_of: :registration

  delegate :name, :email, :cell_phone, :home_phone, :work_phone, :birthday,
           :lodging_id, # ...
           to: :user

  validates :locality, presence: true
  validates_inclusion_of :has_been_paid, in: [true, false]
  validates_inclusion_of :has_medical_release_form, in: [true, false]

  after_create :create_event_locality

  PAYMENT_TYPE = %w(cash check)
  STATUS = %w(attended excused y)

  # scopes
  def self.locality_roster(locality, event)
    where(locality: locality, event: event)
  end
  
  def self.for_event(event)
    where(event: event)
  end

  def self.paid
    where(has_been_paid: true)
  end

  # TODO: pay(amount)
  # TODO paid?

  def payment_adjustment
    @payment_adjustment ||= 0
  end

  protected

  def create_event_locality
    EventLocality.find_or_create_by(event: event, locality: user.locality)
  end
end
