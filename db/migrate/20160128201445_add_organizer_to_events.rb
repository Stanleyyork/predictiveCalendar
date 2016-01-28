class AddOrganizerToEvents < ActiveRecord::Migration
  def change
    add_column :events, :organizer_name, :string
    add_column :events, :organizer_email, :string
    add_column :events, :organizer_self, :boolean
  end
end
