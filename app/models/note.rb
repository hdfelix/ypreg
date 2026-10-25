class Note < ApplicationRecord
  belongs_to :user, inverse_of: :notes
  belongs_to :event

  validates :user_id, presence: true
end
