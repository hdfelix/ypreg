require 'rails_helper'

describe LocationPolicy do
  subject { described_class }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, role: 'admin' }

  permissions :index?, :show?, :new?, :create?, :update?, :destroy? do
    it "denies access if not an admin" do
      expect(subject).not_to permit(current_user)
    end
    it "allows access for an admin" do
      expect(LocationPolicy).to permit(admin)
    end 
  end
end
