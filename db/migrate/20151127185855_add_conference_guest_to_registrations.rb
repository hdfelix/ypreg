class AddConferenceGuestToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :conference_guest, :boolean, default: false
  end
end
