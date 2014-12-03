require 'rails_helper'

describe Lodging, type: :model do
  describe 'Constants' do
    it { should have_constant :LODGING_TYPE }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state_abbrv }
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :lodging_type }
    it { should validate_presence_of :contact_person }
  end

  describe 'Associations' do
    it { should have_many :hospitalities }
    it { should have_many(:events).through(:hospitalities) } # how to test 'uniq'
    # it { should have_one :contact_person }
    it { should belong_to :locality }
    it { should accept_nested_attributes_for :contact_person }
  end
  describe 'Interface' do
    describe '#display_address'
    describe '#display_description'
    describe '#contact_person_home_phone'
    describe '#contact_person_cell_phone'
    describe '#address'
    describe '#display_min_capacity'
    describe '#display_max_capacity'
  end
end
