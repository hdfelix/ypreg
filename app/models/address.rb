class Address < ApplicationRecord
  validates :address1, presence: true
  validates :city, presence: true
  validates :state_abbrv, presence: true
  validates :zipcode, presence: true
end
