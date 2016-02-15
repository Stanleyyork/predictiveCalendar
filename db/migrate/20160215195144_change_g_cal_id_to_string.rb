class ChangeGCalIdToString < ActiveRecord::Migration
  def up
  	change_column :attendees, :gcal_attendee_id, :string
  end
end
