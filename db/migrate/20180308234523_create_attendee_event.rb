class CreateAttendeeEvent < ActiveRecord::Migration
  def change
    create_table :attendees_events, :id => false do |t|
    	t.column :attendee_id, :integer
    	t.column :event_id, :integer
    end
  end
end
