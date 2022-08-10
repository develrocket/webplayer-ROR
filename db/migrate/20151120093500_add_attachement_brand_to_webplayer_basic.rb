class AddAttachementBrandToWebplayerBasic < ActiveRecord::Migration
  def self.up
    change_table :webplayer_basics do |t|
      t.attachment :brand
    end
  end

  def self.down
    remove_attachment :webplayer_basics, :brand
  end
end
