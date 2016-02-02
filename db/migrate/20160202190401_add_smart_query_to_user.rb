class AddSmartQueryToUser < ActiveRecord::Migration
  def change
    add_column :users, :smart_query, :boolean
  end
end
