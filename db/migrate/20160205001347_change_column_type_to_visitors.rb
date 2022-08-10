class ChangeColumnTypeToVisitors < ActiveRecord::Migration
  def change
    remove_column :visitors, :visitor_email_id
    add_column :visitors, :visitor_email_id,  :integer, default: 0
  end
end
