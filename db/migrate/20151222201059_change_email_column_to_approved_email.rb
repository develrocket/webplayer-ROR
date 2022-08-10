class ChangeEmailColumnToApprovedEmail < ActiveRecord::Migration
  def change
    add_index :approved_emails, :email,                unique: true
  end
end
