class AddAttachmentIdfrontToIdcards < ActiveRecord::Migration
  def self.up
    change_table :idcards do |t|
      t.attachment :idfront
    end
  end

  def self.down
    remove_attachment :idcards, :idfront
  end
end
