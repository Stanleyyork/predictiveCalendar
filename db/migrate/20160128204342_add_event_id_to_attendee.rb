class AddEventIdToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :event_id, :integer
  end
end
