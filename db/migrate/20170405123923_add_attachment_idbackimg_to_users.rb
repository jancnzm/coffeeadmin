class AddAttachmentIdbackimgToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :idbackimg
    end
  end

  def self.down
    remove_attachment :users, :idbackimg
  end
end
