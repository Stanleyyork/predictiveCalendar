class AddDefaultPrivacyToUser < ActiveRecord::Migration
  def self.up
    change_column :users, :private_profile, :boolean, :default => true
  end
end
