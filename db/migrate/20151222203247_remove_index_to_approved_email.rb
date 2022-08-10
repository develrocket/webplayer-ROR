class RemoveIndexToApprovedEmail < ActiveRecord::Migration
  def change
    remove_index :approved_emails, :email
  end
end
