class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :gcal_attendee_id
      t.string :email
      t.string :display_name
      t.boolean :organizer
      t.boolean :self
      t.boolean :resource
      t.boolean :optional
      t.string :response_status
      t.string :comment
      t.integer :additional_guests

      t.timestamps null: false
    end
  end
end
