class SetDefaultForUser < ActiveRecord::Migration
  def self.up
    change_column :users, :smart_query, :boolean, :default => true
  end
end
