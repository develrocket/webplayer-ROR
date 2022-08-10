class AddAttachmentToAgentBranding < ActiveRecord::Migration
  def self.up
    change_table :agent_brandings do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :agent_brandings, :avatar
  end
end
