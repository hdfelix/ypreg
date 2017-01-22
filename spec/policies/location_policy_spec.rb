require 'rails_helper'

describe LocationPolicy do
  subject { described_class }

  let(:admin) { FactoryGirl.build_stubbed :user, role: 'admin' }
  let(:scyp_user) { FactoryGirl.build_stubbed :user, role: 'scyp' }
  let(:other_user) { FactoryGirl.build_stubbed :user }

  permissions :index?, :show?, :new?, :edit?, :update?, :create? do
    context 'denies access to' do
      it 'all but admin and scyp users' do
        expect(subject).not_to permit(other_user)
      end
    end

    context 'allows access to' do
      it 'admins' do
        expect(subject).to permit(admin)
      end

      it 'scyp users' do
        expect(subject).to permit(scyp_user)
      end
    end
  end

  permissions :destroy? do
    it 'denies all but admins' do
      expect(subject).to permit(admin)
      expect(subject).not_to permit(other_user)
      expect(subject).not_to permit(scyp_user)
    end
  end
end
