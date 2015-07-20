require 'rails_helper'

RSpec.describe Event::LocalitiesController, type: :controller do
  describe 'Get #index' do
    it 'assigns all localities to @localities' do
      locality_names = create_list(:locality, 2).map(&:city)
      ev = create(:event_with_registrations, registrations_count: 1)
      loc_with_registration = ev.registrations.first.locality
      get :index
      expect(assigns(:localities).map(&:city)).to include(locality_names.first)
      expect(assigns(:localities).map(&:city)).to include(locality_names.second)
      expect(assigns(:localities).map(&:city)).to_not include(loc_with_registration)
    end
  end
end
