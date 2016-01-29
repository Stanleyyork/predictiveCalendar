class Changegceforattendee < ActiveRecord::Migration
  def up
  	change_column :attendees, :event_id, :string
  end
end
