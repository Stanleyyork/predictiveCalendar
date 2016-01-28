class AddLinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :html_link, :string
  end
end
