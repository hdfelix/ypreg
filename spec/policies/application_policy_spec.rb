require 'rails_helper'

describe ApplicationPolicy do
  subject { described_class }
  
  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, role: 'admin' }

  permissions :index?, :show?, :new?, :create?, :update?, :edit?, :destroy? do
    it 'denies access to all' do
      expect(subject).not_to permit(current_user)
      expect(subject).not_to permit(admin)
    end
  end
end
