require 'rails_helper'

describe EventLocality, type: :model do
  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :locality }
  end
end
