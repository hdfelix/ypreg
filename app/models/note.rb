class Note < ApplicationRecord
  belongs_to :user, inverse_of: :notes
  belongs_to :event

  validates_presence_of :user_id
end
