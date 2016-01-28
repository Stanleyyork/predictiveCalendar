class AddSyncsToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :next_page_token, :string
    add_column :calendars, :next_sync_token, :string
  end
end
