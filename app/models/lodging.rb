# Places for hospitality (home, hotel room, retreat center lodging unit, etc.
class Lodging < ApplicationRecord
  # LODGING_TYPE = [['Home', 1], ['Retreat Center', 2], ['Hotel/Motel', 3]]
  LODGING_TYPE = { 1 => 'Home', 2 => 'Retreat Center', 3 => 'Hotel/Motel' }

  belongs_to :locality, optional: true
  belongs_to :contact_person, required: true, class_name: 'User' # TODO: Changed to required: true 6/9/18

  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state_abbrv, presence: true
  validates :zipcode, presence: true
  validates :lodging_type, presence: true
  validates :contact_person, presence: true
  validates :min_capacity, presence: true

  accepts_nested_attributes_for :contact_person

  def users_that_are_not_contact_people
    users = User.not_contact_persons.to_a
    unless contact_person.nil?
      users << contact_person
      users
    end
    users
  end

  def display_address_in_address_block_format
    "#{address1}\n#{city}, #{state_abbrv}  #{zipcode}"
  end

  def display_description
    if description.nil?
      '--'
    else
      description
    end
  end

  def contact_person_home_phone
    home_phone = contact_person.home_phone
    if home_phone.nil?
      '--'
    else
      home_phone
    end
  end

  def contact_person_cell_phone
    cell_phone = contact_person.cell_phone
    if cell_phone.nil?
      '--'
    else
      cell_phone
    end
  end

  def address
    address1 + ' ' + city + ', ' + state_abbrv + '  ' + zipcode.to_s
  end

  def display_min_capacity
    if min_capacity.nil?
      '--'
    else
      min_capacity
    end
  end

  def display_max_capacity
    if max_capacity.nil?
      '--'
    else
      max_capacity
    end
  end
end
