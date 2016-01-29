class ChangeReocurringIdToEvent < ActiveRecord::Migration
  def up
    change_column :events, :recurring_event_id, :string
  end
end
