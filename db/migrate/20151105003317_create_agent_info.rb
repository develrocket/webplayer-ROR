class CreateAgentInfo < ActiveRecord::Migration
  def change
    create_table :agent_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :company
      t.string :avatar
      t.boolean :is_show_agent_branding
      t.text :tooltip
    end
  end
end
