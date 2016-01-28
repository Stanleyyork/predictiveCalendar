class AddCreatorSelfToEvents < ActiveRecord::Migration
  def change
    add_column :events, :creator_self, :boolean
  end
end
