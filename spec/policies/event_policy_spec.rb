require 'rails_helper'

describe EventPolicy do
  subject { described_class }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, role: 'admin' }

  permissions :index?, :show?, :new?, :edit?, :update?, :create?, :destroy? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_user)
    end

    it 'allows access to admins' do
      expect(subject).to permit(admin)
    end
  end
end
