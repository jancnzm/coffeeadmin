class AddAttachmentIdfontimgToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :idfontimg
    end
  end

  def self.down
    remove_attachment :users, :idfontimg
  end
end
