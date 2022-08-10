class AddColumnsToTours < ActiveRecord::Migration
  def change
    add_column :tours, :agent_branding, :boolean, default: true
    add_column :tours, :display_contents, :boolean, default: true
    add_column :tours, :restriction_option, :boolean, default: true
    add_column :tours, :data_log, :boolean, default:true
    add_column :tours, :statistic, :boolean, default:true
    remove_column :tours, :name
  end
end
