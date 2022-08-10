class RenameEmailIdToVisitor < ActiveRecord::Migration
  def change
    rename_column :visitors, :email_id, :visitor_email_id
  end
end
