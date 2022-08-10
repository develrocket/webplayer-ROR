class RemoveAccessQuestedColumnToVisitorEmail < ActiveRecord::Migration
  def change
    remove_column :visitor_emails, :access_requested
  end
end
