class AddAdLinkToWebplayerBasic < ActiveRecord::Migration
  def change
    add_column :webplayer_basics, :ad_link, :string, default: ''
  end
end
