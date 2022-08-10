class AddAdminIdToDisplayOptions < ActiveRecord::Migration
  def change
    add_column :display_options, :admin_id, :integer, null:false, default: 0
  end
end
