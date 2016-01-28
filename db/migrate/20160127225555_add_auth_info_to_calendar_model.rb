class AddAuthInfoToCalendarModel < ActiveRecord::Migration
  def change
    add_column :calendars, :code, :string
    add_column :calendars, :refresh_token, :string
  end
end
