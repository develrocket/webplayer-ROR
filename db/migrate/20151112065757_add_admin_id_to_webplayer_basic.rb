class AddAdminIdToWebplayerBasic < ActiveRecord::Migration
  def change
    add_column :webplayer_basics, :admin_id, :integer, null:false, default: 0
  end
end
