class ChangeGcalEventId < ActiveRecord::Migration
  def up
    change_column :events, :gcal_event_id, :string
  end
end
