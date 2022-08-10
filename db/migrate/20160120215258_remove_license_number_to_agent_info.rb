class RemoveLicenseNumberToAgentInfo < ActiveRecord::Migration
  def change
    remove_column :agent_infos, :license_number
    add_column :agent_infos, :license_number, :string, default: ''
  end
end
