class AddColumnsToWebplayerBasic < ActiveRecord::Migration
  def change
    add_column :webplayer_basics, :tour_address, :string
    add_column :webplayer_basics, :matterport_link, :string
    add_column :webplayer_basics, :brand, :string
    add_column :webplayer_basics, :media, :string
    rename_column :webplayer_basics, :admin_id, :tour_id
  end
end
