class AddAttachmentImageToPanels < ActiveRecord::Migration
  def self.up
    change_table :panels do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :panels, :image
  end
end
