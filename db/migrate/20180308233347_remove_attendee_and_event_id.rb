class RemoveAttendeeAndEventId < ActiveRecord::Migration
  def change
  	remove_column :events, :attendees_id
  	remove_column :attendees, :event_id
  end
end
