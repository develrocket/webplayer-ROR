class ChangeAgentInfoColumnToAgentInfo < ActiveRecord::Migration
  def change
    rename_column :agent_infos, :unique_agent_id, :license_number
  end
end
