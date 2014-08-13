class Hospitality < ActiveRecord::Base
  #has_many :registrations, through: :hospitality_assignments
  belongs_to :events
  belongs_to :lodgings
  has_many :hospitality_assignments
  has_many :registrations, -> { uniq }, through: :hospitality_assignments

  def lodging
    Lodging.find(self.lodging_id)
  end
  
end
