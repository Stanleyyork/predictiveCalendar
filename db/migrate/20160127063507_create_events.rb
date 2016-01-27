class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :attendees_id
      t.boolean :attachments
      t.boolean :anyone_can_add_self
      t.timestamp :created
      t.string :creator
      t.string :description
      t.timestamp :end
      t.boolean :guests_can_invite_others
      t.boolean :guests_can_see_other_guests
      t.integer :gcal_event_id
      t.string :location
      t.string :organizer
      t.timestamp :original_start_time
      t.boolean :recurrence
      t.integer :recurring_event_id
      t.string :reminders
      t.timestamp :start
      t.string :status
      t.string :summary
      t.timestamp :update
      t.string :visibility

      t.timestamps null: false
    end
  end
end
