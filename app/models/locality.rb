# == Schema Information
#
# Table name: localities
#
#  id                 :integer          not null, primary key
#  city               :string(255)
#  state_abbrv        :string(255)
#  contact_id         :integer
#  lodging_contact_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

# A local church
class Locality < ActiveRecord::Base
  has_many :users
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
