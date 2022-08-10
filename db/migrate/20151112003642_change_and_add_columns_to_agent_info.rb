class ChangeAndAddColumnsToAgentInfo < ActiveRecord::Migration
  def change
    remove_column :agent_infos, :company
    change_column :agent_infos, :first_name,  :string, null: false, default: ""
    change_column :agent_infos, :last_name,  :string, null: false, default: ""
    rename_column :agent_infos, :phone,  :mobile_phone
    add_column :agent_infos, :office_phone, :string
    add_column :agent_infos, :fax, :string
    add_column :agent_infos, :title, :string
    add_column :agent_infos, :website, :string
    add_column :agent_infos, :fb_profile, :string
    add_column :agent_infos, :twitter_profile, :string
    add_column :agent_infos, :linkedin, :string
    add_column :agent_infos, :office_address, :string
    add_column :agent_infos, :city, :string
    add_column :agent_infos, :zip_code, :string
    add_column :agent_infos, :state_id, :integer
    add_column :agent_infos, :coutnry_id, :integer
  end
end
