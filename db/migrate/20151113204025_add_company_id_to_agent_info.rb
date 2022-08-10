class AddCompanyIdToAgentInfo < ActiveRecord::Migration
  def change
    remove_column :admins, :company_id
    add_column :agent_infos, :company_id,  :integer, null: false, default: 0
  end
end
