class AddAttachementMediaToWebplayerBasic < ActiveRecord::Migration
  def self.up
    change_table :webplayer_basics do |t|
      t.attachment :media
    end
  end

  def self.down
    remove_attachment :webplayer_basics, :media
  end
end
