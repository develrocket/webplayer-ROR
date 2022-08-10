class AddAdminIdToRestrictOptions < ActiveRecord::Migration
  def change
    add_column :restrict_options, :admin_id, :integer, null:false, default: 0
  end
end
