require 'spec_helper'

# TODO: this isn't working; throwing unauthorized user error for non-existant user and
# "undefined method 'none?' for nil:NilClass
# http://thunderboltlabs.com/blog/2013/03/27/testing-pundit-policies-with-rspec/

# describe LocationPolicy do
#   subject { LocationPolicy.new(user, location) }
# 
#   let(:location) { FactoryGirl.create(:location) }
# 
#   context 'for a visitor' do
#     let(:user) { FactoryGirl.create(:user, role: 'admin') }
# 
#     it { should_not permit(:index) }
#   end
# end
