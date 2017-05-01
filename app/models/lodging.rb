# Places for hospitality (home, hotel room, retreat center lodging unit, etc.
class Lodging < ActiveRecord::Base
  validates :address1, presence: true
  validates :city, presence: true
  validates :min_capacity, presence: true
  validates :name, presence: true
  validates :state_abbrv, presence: true
  validates :lodging_type, presence: true
  validates :zipcode, presence: true

  LODGING_TYPE = {1 => 'Home', 2 => 'Retreat Center', 3 => 'Hotel/Motel'}

end
