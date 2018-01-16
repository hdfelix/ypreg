require 'rails_helper'

describe LocalityPolicy do
  subject { described_class }

  let(:admin) { FactoryBot.build_stubbed :user, role: 'admin' }
  let(:scyp) { FactoryBot.build_stubbed :user, role: 'scyp' }
  let(:loc_contact) { FactoryBot.build_stubbed :user, role: 'loc_contact' }
  let(:hosp_contact) { FactoryBot.build_stubbed :user, role: 'hosp_contact' }
  let(:trainee) { FactoryBot.build_stubbed :user, role: 'trainee' }
  let(:speaking_brother) { FactoryBot.build_stubbed :user, role: 'speaking_brother' }
  let(:supporting_brother) { FactoryBot.build_stubbed :user, role: 'supporting_brother' }
  let(:helper) { FactoryBot.build_stubbed :user, role: 'helper' }
  let(:yp) { FactoryBot.build_stubbed :user, role: 'yp' }
  let(:guest) { FactoryBot.build_stubbed :user, role: 'guest' }

  permissions :index? do
    it 'allows admin users' do
      expect(subject).to permit(admin)
    end

    it 'allows scyp users' do
      expect(subject).to permit(scyp)
    end

    it 'does not allow hosp_contact users' do
      expect(subject).not_to permit(hosp_contact)
    end

    it 'does not allow trainee users' do
      expect(subject).not_to permit(trainee)
    end

    it 'does not allow speaking_brother users' do
      expect(subject).not_to permit(speaking_brother)
    end

    it 'does not allow supporting_brother users' do
      expect(subject).not_to permit(supporting_brother)
    end

    it 'does not allow helper users' do
      expect(subject).not_to permit(helper)
    end

    it 'does not allow yp users' do
      expect(subject).not_to permit(yp)
    end

    it 'does not allow guest users' do
      expect(subject).not_to permit(guest)
    end
  end

  permissions :show?, :new?, :edit?, :update?, :create?, :destroy? do
    it 'denies access to loc_contact users' do
      expect(subject).not_to permit(loc_contact)
    end

    it 'denies access to hosp_contact users' do
      expect(subject).not_to permit(hosp_contact)
    end

    it 'denies access to trainee users' do
      expect(subject).not_to permit(trainee)
    end

    it 'denies access to speaking_brother users' do
      expect(subject).not_to permit(speaking_brother)
    end

    it 'denies access to supporting_brother users' do
      expect(subject).not_to permit(supporting_brother)
    end

    it 'denies access to helper users' do
      expect(subject).not_to permit(helper)
    end

    it 'denies access to yp users' do
      expect(subject).not_to permit(yp)
    end

    it 'denies access to guest users' do
      expect(subject).not_to permit(guest)
    end

    it 'allows admin' do
      expect(subject).to permit(admin)
    end
  end
end
