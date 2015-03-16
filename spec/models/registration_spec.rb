require 'rails_helper'

describe Registration, type: :model do
  describe 'Constants' do
    it { should have_constant :PAYMENT_TYPE }
  end

  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :event }
    it { should have_many :hospitality_registration_assignments }
    # it do
    #   should have_many(:hospitalities)
    #     .through(:hospitality_registration_assignments)
    #     .conditions(:uniq)
    # end

    it { should delegate_method(:name).to(:user) }
    it { should delegate_method(:email).to(:user) }
    it { should delegate_method(:cell_phone).to(:user) }
    it { should delegate_method(:home_phone).to(:user) }
    it { should delegate_method(:work_phone).to(:user) }
    it { should delegate_method(:birthday).to(:user) }
    it { should delegate_method(:lodging_id).to(:user) }
  end
end
