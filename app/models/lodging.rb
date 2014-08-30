# == Schema Information
#
# Table name: lodgings
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  address1     :string(255)
#  address2     :string(255)
#  city         :string(255)
#  state_abbrv  :string(255)
#  zipcode      :integer
#  lodging_type :string(255)
#  locality_id  :integer
#  max_capacity :string(255)
#  min_capacity :string(255)
#

# Places for hospitality (home, hotel room, retreat center lodging unit, etc.
class Lodging < ActiveRecord::Base
  # has_and_belongs_to_many :events
  has_many :hospitalities
  has_many :events, -> { uniq }, through: :hospitalities
  has_one :contact_person, class_name: 'User'
  belongs_to :locality

  accepts_nested_attributes_for :contact_person

  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state_abbrv, presence: true
  validates :zipcode, presence: true
  validates :lodging_type, presence: true
  validates :contact_person, presence: true

  LODGING_TYPE = [['Home', 1], ['Retreat Center', 2], ['Hotel/Motel', 3]]

  def display_address
    "#{address1} \n #{city}, #{state_abbrv}  #{zipcode}"
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
