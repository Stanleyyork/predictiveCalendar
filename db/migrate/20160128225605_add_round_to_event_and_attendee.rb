class AddRoundToEventAndAttendee < ActiveRecord::Migration
  def change
    add_column :events, :round, :integer
    add_column :attendees, :round, :integer
  end
end
