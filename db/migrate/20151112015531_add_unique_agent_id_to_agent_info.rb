class AddUniqueAgentIdToAgentInfo < ActiveRecord::Migration
  def change
    add_column :agent_infos, :unique_agent_id, :string, null:false, default: ""
    add_index :agent_infos, :unique_agent_id,                unique: true
  end
end
