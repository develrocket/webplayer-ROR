class ChangeCountryIdToAgentInfo < ActiveRecord::Migration
  def change
    rename_column :agent_infos, :coutnry_id, :country_id
  end
end
