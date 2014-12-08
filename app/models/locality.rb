# A local church
class Locality < ActiveRecord::Base
  has_many :users
  has_many :hospitality_assignments
  has_many :lodgings
  has_many :hospitalities
  belongs_to :contact, class_name: 'User', foreign_key: 'contact_id'
  belongs_to :lodging_contact, class_name: 'User', foreign_key: 'lodging_contact_id'
  # has_and_belongs_to_many :lodgings

  validates :city, presence: true
  validates :state_abbrv, presence: true

  def display_contact
    if contact_id.nil?
      '--'
    else
      User.find(contact_id).name
    end
  end

  def display_contact_with_contact_info
    if contact_id.nil?
      '--'
    else
      contact = User.find(contact_id)
      "#{contact.name} (#{contact.email})"
    end
  end
end
