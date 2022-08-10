class AddExteriorLinkToWebplayerBasic < ActiveRecord::Migration
  def change
    remove_column :webplayer_basics, :url
    remove_column :webplayer_basics, :embed_code
    add_column :webplayer_basics, :exterior_link, :string, default:''
  end
end
