class AddUserIdToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :user_id, :integer
  end
end
