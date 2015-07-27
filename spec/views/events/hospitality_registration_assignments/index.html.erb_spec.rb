require 'rails_helper'

describe 'events/hospitality_registration_assignments/index' do
  before(:each) do
    saints = [double(:user)]
    @event = double(:event)
    @localities = [double(:locality, id: 1000, city: 'city')]
    allow(@event).to receive(:localities).and_return(@localities)
    allow(@event).to receive(:registered_saints_from_locality).
      and_return(saints)
  end

  it "Contains a 'Participating Localities' table" do
    render
      expect(rendered).to have_selector('table tr')
      expect(rendered).to have_content('Saint to Hospitality Assignments')
  end
end
