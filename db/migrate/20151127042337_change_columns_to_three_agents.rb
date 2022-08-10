class ChangeColumnsToThreeAgents < ActiveRecord::Migration
  def change
    rename_column :display_options, :admin_id, :tour_id
    rename_column :restrict_options, :admin_id, :tour_id
    rename_column :visitors, :admin_id, :tour_id
  end
end
