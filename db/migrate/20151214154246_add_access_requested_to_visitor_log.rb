class AddAccessRequestedToVisitorLog < ActiveRecord::Migration
  def change
    add_column :visitor_logs, :access_requested, :boolean, default: false
  end
end
