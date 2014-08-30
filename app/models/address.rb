# == Schema Information
#
# Table name: addresses
#
#  id           :integer          not null, primary key
#  addressline1 :string(255)
#  addressline2 :string(255)
#  city         :string(255)
#  state_abbrv  :string(255)
#  zipcode      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Address < ActiveRecord::Base
  validates :address1, presence: true
  validates :city, presence: true
  validates :state_abbrv, presence: true
  validates :zipcode, presence: true
end
