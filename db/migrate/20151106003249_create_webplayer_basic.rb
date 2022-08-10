class CreateWebplayerBasic < ActiveRecord::Migration
  def change
    create_table :webplayer_basics do |t|
      t.string :url
      t.text :embed_code
      t.string :height
      t.string :width
      t.text :tooltip
    end
  end
end
