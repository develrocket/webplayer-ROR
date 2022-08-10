class RemoveColumnsFromVisitor < ActiveRecord::Migration
  def change
    remove_column :visitors, :email
    remove_column :visitors, :access_requested
    remove_column :visitors, :is_verified
  end
end
