class AddAttachmentAttchmentimgToAttchments < ActiveRecord::Migration
  def self.up
    change_table :attchments do |t|
      t.attachment :attchmentimg
    end
  end

  def self.down
    remove_attachment :attchments, :attchmentimg
  end
end
