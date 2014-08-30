# == Schema Information
#
# Table name: registrations
#
#  id                    :integer          not null, primary key
#  payment_type          :string(255)
#  has_been_paid         :boolean
#  payment_adjustment    :decimal(, )
#  attend_as_serving_one :boolean
#  user_id               :integer
#  event_id              :integer
#  created_at            :datetime
#  updated_at            :datetime
#  hospitalities_id      :integer
#

# Model for a registration to an event
class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :hospitality_assignments
  has_many :hrspitalities, -> { uniq }, through: :hospitality_assignments

  PAYMENT_TYPE = [['Cash', 1], ['Check', 2]]
end
