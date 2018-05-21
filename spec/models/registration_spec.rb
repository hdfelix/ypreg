require 'rails_helper'

describe Registration, type: :model do
  describe 'Constants' do
    it { is_expected.to have_constant :PAYMENT_TYPE }
    it { is_expected.to have_constant :STATUS }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :event }
    it { is_expected.to belong_to :locality }
    it { is_expected.to belong_to(:hospitality).optional }
    it do
      is_expected.to have_many(:hospitality_registration_assignments)
        .inverse_of(:registration)
    end

    describe 'Validations' do
      it { is_expected.to belong_to :locality }

      it do
        is_expected.to validate_inclusion_of(:has_been_paid)
          .in_array([true, false])
      end

      it do
        is_expected.to validate_inclusion_of(:has_medical_release_form)
          .in_array([true, false])
      end
    end

    describe 'Delegations' do
      it { is_expected.to delegate_method(:name).to(:user) }
      it { is_expected.to delegate_method(:email).to(:user) }
      it { is_expected.to delegate_method(:cell_phone).to(:user) }
      it { is_expected.to delegate_method(:home_phone).to(:user) }
      it { is_expected.to delegate_method(:work_phone).to(:user) }
      it { is_expected.to delegate_method(:birthday).to(:user) }
      it { is_expected.to delegate_method(:lodging_id).to(:user) }
    end
  end
end
