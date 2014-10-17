# A local church
class Locality < ActiveRecord::Base
  has_many :users
  has_many :hospitality_assignments
  has_and_belongs_to_many :lodgings

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

  def hospitality_contact_for
    # self.hospitality_contact_id
  end
end
