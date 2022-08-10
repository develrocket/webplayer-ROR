class AddAdminIdToAgentInfo < ActiveRecord::Migration
  def change
    add_column :agent_infos, :admin_id, :integer, null: false, default: 0
  end
end
