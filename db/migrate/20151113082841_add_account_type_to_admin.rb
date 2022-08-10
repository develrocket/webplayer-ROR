class AddAccountTypeToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :agent_type,  :integer, null: false, default: 2
  end
end
