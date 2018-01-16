require 'rails_helper'

describe EventCopyPolicy do
  subject { described_class }

  let(:current_user) { FactoryBot.build_stubbed :user }
  let(:other_user) { FactoryBot.build_stubbed :user }
  let(:admin) { FactoryBot.build_stubbed :user, role: 'admin' }

  permissions :new?, :create? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_user)
    end

    it 'allows access for an admin' do
      expect(subject).to permit(admin)
    end
  end
end
