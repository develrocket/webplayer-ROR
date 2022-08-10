class AddAdminIdToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :admin_id, :integer, null:false, default: 0
  end
end
