require 'rails_helper'

describe Hospitality, type: :model do

  describe 'Associations' do
    it { should belong_to :event }
    it { should belong_to :lodging }
    it { should belong_to :locality }
    it { should have_many :hospitality_assignments }
    it { should have_many(:registrations).through(:hospitality_assignments) }
  end
end
