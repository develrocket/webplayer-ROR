class ChangColumnToTours < ActiveRecord::Migration
  def change
    rename_column :tours, :agent_branding, :is_agent_branding
    rename_column :tours, :display_contents, :is_display_contents
    rename_column :tours, :restriction_option, :is_restriction_option
    rename_column :tours, :data_log, :is_data_log
    rename_column :tours, :statistic, :is_statistic
  end
end
