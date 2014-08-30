# == Schema Information
#
# Table name: hospitality_assignments
#
#  id              :integer          not null, primary key
#  hospitality_id  :integer
#  registration_id :integer
#

# A hospitality assigment for an event
class HospitalityAssignment < ActiveRecord::Base
  belongs_to :registration
  belongs_to :hospitality
end
