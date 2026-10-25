require 'rails_helper'

describe Note, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :event }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :user_id }
  end
end
