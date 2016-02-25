class AddAlgoliaToEvent < ActiveRecord::Migration
  def change
    add_column :events, :algolia, :boolean
  end
end
