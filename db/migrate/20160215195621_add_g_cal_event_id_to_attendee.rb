class AddGCalEventIdToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :gcal_event_id, :string
  end
end
