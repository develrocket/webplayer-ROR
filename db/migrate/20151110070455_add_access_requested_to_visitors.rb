class AddAccessRequestedToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :access_requested, :boolean, null: false, default: false
  end
end
