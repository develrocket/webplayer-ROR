class AddAttachmentAvatarToAgentInfo < ActiveRecord::Migration
  def self.up
    change_table :agent_infos do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :agent_infos, :avatar
  end
end
