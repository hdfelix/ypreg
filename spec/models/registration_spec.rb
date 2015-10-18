require 'rails_helper'

describe Registration, type: :model do
  describe 'Constants' do
    it { should have_constant :PAYMENT_TYPE }
    it { should have_constant :STATUS }
  end

  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :event }
    it { should belong_to :locality }
    it { should belong_to :hospitality }
    it do
      should have_many(:hospitality_registration_assignments)
        .inverse_of(:registration)
    end

    describe 'Validations' do
      it { should belong_to :locality }

      it do
        should validate_inclusion_of(:has_been_paid)
          .in_array([true, false])
      end

      it do
        should validate_inclusion_of(:has_medical_release_form)
          .in_array([true, false])
      end
    end

    describe 'Delegations' do
      it { should delegate_method(:name).to(:user) }
      it { should delegate_method(:email).to(:user) }
      it { should delegate_method(:cell_phone).to(:user) }
      it { should delegate_method(:home_phone).to(:user) }
      it { should delegate_method(:work_phone).to(:user) }
      it { should delegate_method(:birthday).to(:user) }
      it { should delegate_method(:lodging_id).to(:user) }
    end
  end
end
