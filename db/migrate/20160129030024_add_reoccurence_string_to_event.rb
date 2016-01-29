class AddReoccurenceStringToEvent < ActiveRecord::Migration
  def change
    add_column :events, :recurrence_value, :string
  end
end
