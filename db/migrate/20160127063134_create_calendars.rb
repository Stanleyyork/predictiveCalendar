class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
