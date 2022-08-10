class AddDefaultUnitNameToWebplayerBasic < ActiveRecord::Migration
  def change
    add_column :webplayer_basics, :default_unit_name, :string, default: 'Main Unit'
  end
end
