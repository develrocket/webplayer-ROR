class ChangeColumnToNotification < ActiveRecord::Migration
  def change
    rename_column :notifications, :tour_id, :admin_id
  end
end
