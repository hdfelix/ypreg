# Model for a registration to an event
class Registration < ActiveRecord::Base
  PAYMENT_TYPE = ['Cash', 'Check']

  belongs_to :user
  belongs_to :event
  belongs_to :locality
  belongs_to :hospitality
  has_many :hospitality_registration_assignments, inverse_of: :registration
  
  delegate :name, :email, :cell_phone, :home_phone, :work_phone, :birthday,
    :lodging_id, # ...
           to: :user

  # validates :locality, presence: true
  validates_inclusion_of :has_been_paid, in: [true, false]
  validate :has_medical_release_form, presence: true

  after_create :create_event_locality

  private

  def create_event_locality
    EventLocality.find_or_create_by(event: self.event, locality: self.user.locality)
  end
end
