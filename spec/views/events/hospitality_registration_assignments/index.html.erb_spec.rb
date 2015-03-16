require 'rails_helper'

# Why do all tests in here always pass even if I change the expectations to be clearly wrong?
describe 'show.html.erb' do
  before(:each) do
    @event = FactoryGirl.create(:event)
  end

  it "contains a 'Hospitalty Info' table" do
    redirect_to event_path(@event)
    within("hospitality_info_widget") do
      expect(rendered).to have_selector('h3', text: 'Hospitality Info')
    end
  end

  context "Hospitality Info table" do
    it "contains a 'Manage Hospitalities' button" do
      redirect_to event_path(@event)

      within("hospitality_info_widget") do
        expect(rendered).to have_content('Manage Hospitalities')
      end
    end

    it "contains an 'Assign Localities' button" do
      redirect_to event_path(@event)

      within("hospitality_info_widget") do
        expect(rendered).to have_content('Assign Localities')
      end
    end

    it "contains an 'Assign Saints' button" do
      redirect_to event_path(@event)

      within("hospitality_info_widget") do
        expect(rendered).to have_content('Assign Burgers')
      end
    end
  end
end
