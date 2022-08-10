class ChangeColumnToAgentInfo < ActiveRecord::Migration
  def change
    change_column :agent_infos, :company_id, :integer
  end
end
