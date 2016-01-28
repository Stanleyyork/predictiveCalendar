class ChangeUpdateColumnName < ActiveRecord::Migration
  def self.up
    rename_column :events, :update, :updated
  end
end
