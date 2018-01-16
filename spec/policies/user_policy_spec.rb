require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  let(:admin) { FactoryBot.build_stubbed :user, role: 'admin' }
  let(:other_user) { FactoryBot.build_stubbed :user }

  permissions :index?, :show?, :new?, :edit?, :update?, :create?, :destroy? do
    context 'it denies access to all except' do
      it 'admins' do
        expect(subject).not_to permit(other_user)
      end
    end

    context 'it allows access to' do
      it 'admins' do
        expect(subject).to permit(admin)
      end
    end
  end
end
