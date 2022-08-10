class RemoveTwoColumnToAgentInfo < ActiveRecord::Migration
  def change
    remove_column :agent_infos, :first_name
    remove_column :agent_infos, :last_name
  end
end
