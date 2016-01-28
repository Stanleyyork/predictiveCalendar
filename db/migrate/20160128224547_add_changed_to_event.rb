class AddChangedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :syncd_and_changed, :boolean
  end
end
