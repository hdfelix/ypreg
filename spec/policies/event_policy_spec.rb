require 'rails_helper'

describe EventPolicy do
  subject { described_class }

  let(:admin) { FactoryBot.build_stubbed :user, role: 'admin' }
  let(:scyp_user) { FactoryBot.build_stubbed :user, role: 'scyp' }
  let(:loc_contact_user) { FactoryBot.build_stubbed :user, role: 'loc_contact' }

  permissions :index?, :show?, :new?, :edit?, :update?, :create?, :destroy? do
    it 'allows access to admins' do
      expect(subject).to permit(admin)
    end

    it 'allows access to scyp' do
      expect(subject).to permit(scyp_user)
    end
  end

  # More retricted access
  permissions :index?, :show? do
    it 'allows access to loc_contacts' do
      expect(subject).to permit(loc_contact_user)
    end
  end
end
