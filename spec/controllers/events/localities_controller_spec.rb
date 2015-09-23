require 'rails_helper'

# describe LocalitiesController, type: :controller do
#   before(:example) do
#     sign_in_user(double('user', role?: 'admin'))
#   end
# 
#   describe 'GET :index' do
#     it 'assigns all localities not participating in the event to @localities' do
#       locality_names = create_list(:locality, 2).map(&:city)
#       ev = create(:event_with_registrations, registrations_count: 1)
#       loc_with_registration = ev.registrations.first.locality
# 
#       get :index
# 
#       expect(assigns(:localities).map(&:city)).to include(locality_names.first)
#       expect(assigns(:localities).map(&:city)).to include(locality_names.second)
#       expect(assigns(:localities).map(&:city)).to_not include(loc_with_registration)
#     end
# 
#     it 'assigns all event localities to @event_localities' do
#       event = create(:event_with_registrations, ensure_unique_locality: false)
#       event_localities = event.localities.map(&:city)
# 
#       get :index
# 
#       expect(assigns(:event_localities)).to match_array([event_localities])
#     end
#   end
# end
