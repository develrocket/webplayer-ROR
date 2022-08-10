class ChangeColumnDefaultValueToDisplayOption < ActiveRecord::Migration
  def change
    change_column :display_options, :show_google45_imagery, :boolean, default: true
    change_column :display_options, :show_exterior_walkin, :boolean, default: true
    change_column :display_options, :show_detach_unit, :boolean, default: true
  end
end
