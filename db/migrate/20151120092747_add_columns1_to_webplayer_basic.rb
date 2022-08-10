class AddColumns1ToWebplayerBasic < ActiveRecord::Migration
  def change
    add_column :webplayer_basics, :is_brand_show, :boolean, default: true
    add_column :webplayer_basics, :is_media_show, :boolean, default: true
    add_column :webplayer_basics, :brand_width, :string
    add_column :webplayer_basics, :brand_height, :string
    add_column :webplayer_basics, :media_width, :string
    add_column :webplayer_basics, :media_height, :string
  end
end
