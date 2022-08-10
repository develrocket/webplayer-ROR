class AddAttachmentLogoToTourBranding < ActiveRecord::Migration
  def self.up
    change_table :tour_brandings do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :tour_brandings, :logo
  end
end
