class AddPrivacyToUser < ActiveRecord::Migration
  def change
    add_column :users, :private_profile, :boolean
  end
end
