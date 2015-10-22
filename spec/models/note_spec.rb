require 'rails_helper'

describe Note, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :event }
  end

  describe 'Validations' do
    it { should validate_presence_of :user_id }
  end
end
