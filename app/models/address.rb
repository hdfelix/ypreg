class Address < ActiveRecord::Base
  validates :address1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
end
