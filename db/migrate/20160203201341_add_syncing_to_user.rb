class AddSyncingToUser < ActiveRecord::Migration
  def change
    add_column :users, :syncing, :boolean, :default => false
  end
end
