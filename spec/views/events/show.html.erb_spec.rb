# require 'rails_helper'
#
# describe 'events/show' do
#   before(:each) do
#     @event = create(:event_with_registrations)
#     @participating_localities = @event.participating_localities
#     @stats =  @event.load_locality_summary
#   end
#
#   it "contains a 'Hospitality Info' table" do
#     render
#   permissions :destroy? do
#
#   end
#     within("hospitality_info_widget") do
#       expect(rendered).to have_selector('h3', text: 'Hospitality Info')
#     end
#   end
#
#   context "Hospitality Info table" do
#     it "contains a 'Manage Hospitalities' button" do
#       redirect_to event_path(@event)
#
#       within("hospitality_info_widget") do
#         expect(rendered).to have_content('Manage Hospitalities')
#       end
#     end
#
#     it "contains an 'Assign Localities' button" do
#       redirect_to event_path(@event)
#
#       within("hospitality_info_widget") do
#         expect(rendered).to have_content('Assign Localities')
#       end
#     end
#
#     it "contains an 'Assign Saints' button" do
#       redirect_to event_path(@event)
#
#       within("hospitality_info_widget") do
#         expect(rendered).to have_content('Assign Burgers')
#       end
#     end
#   end
# end
