class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :attendees_id
      t.boolean :attachments
      t.boolean :anyone_can_add_self
      t.date_time :created
      t.string :creator
      t.string :description
      t.date_time :end
      t.boolean :guests_can_invite_others
      t.boolean :guests_can_see_other_guests
      t.integer :id
      t.string :location
      t.string :organizer
      t.date_time :original_start_time
      t.boolean :recurrence
      t.integer :recurring_event_id
      t.string :reminders
      t.date_time :start
      t.string :status
      t.string :summary
      t.date_time :update
      t.string :visibility

      t.timestamps null: false
    end
  end
end
