class AddEmailContentToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :additional_email_content, :text, default: ''
  end
end
